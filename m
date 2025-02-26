Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4E6C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 12:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnGXQ-0003MH-FJ; Wed, 26 Feb 2025 07:29:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnGXN-0003Lp-UW
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 07:29:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnGXK-0001e4-BF
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 07:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740572953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YqtUsmTYfSl8QjL4A92EdoUfNd8iKRnEclZHB/5oJQc=;
 b=jFbwewlU90qvE3n7+7Ny2J4EL11f4+wHFaElfVRApA1Q3AU4EZCMJ3RGy1ZqkQqPoWU9uQ
 ino7M4x7IY1SOx9u72/qlDlbj/FOwISCRJW5kaIFhIRUxcCWqgF4vDGS3LTXbJylyV+J+/
 2McsTqRo9GB1UVd53eFFT9xCHXGK9zU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-CNsfkiHDNkCKLlo509PIlw-1; Wed, 26 Feb 2025 07:29:08 -0500
X-MC-Unique: CNsfkiHDNkCKLlo509PIlw-1
X-Mimecast-MFC-AGG-ID: CNsfkiHDNkCKLlo509PIlw_1740572948
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4393ed818ccso48663925e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 04:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740572947; x=1741177747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YqtUsmTYfSl8QjL4A92EdoUfNd8iKRnEclZHB/5oJQc=;
 b=W90Hd8Url5X7x+sWCqIeUr/a6rUygBkjrRZbFlbqxsq2xrFvRkNF6dwSPsjACroseP
 rKhcsxxtfknXXdC1ZcDGkSWhvCXs4e3M/gdDM1+Ow0ozSTfRYYlA25JwFBvqPyzWix39
 p4Qb3fn5pU46DseOe7w4Wa+b0OeQwkW5wARo8XjQ6Nd4/xPDall+RevKKbsc6lNC6eu8
 XYQhUc/7YULL8xUMdyNWBzCVwgjSqoORkz73u+1+E6wZGFfZ6tOmd5x7Req08eLVnPSF
 vGXc9VviYJgCFPTgz59kPBAEkS4kUcHLbIOOWO3TlnxEyN2d3lRYY/n4mD2WUuPOsRWe
 7XoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIECcSGXavwHr7Up3+QAQKpfSWjZPpnMPvf8okA6Zdgk5BdLEcEGyRs3w2yCk0NnY/SvthilcQuh9e@nongnu.org
X-Gm-Message-State: AOJu0YzjQVkiDNLdU7jAmy8icWHDnigOU9RZgPLZ3iZT37jAHgR5UXfV
 WYPMJEJsU5fymHlYlYCfhIqoBgp3XeL5DfStOd9sPSBF6hKwQs15TJ6nubKdgcoCfz3krfXWSp2
 pftD5R4+9xc9G4Clxl+mLIdaWZeSrm5OASCmMvFVmb1SC9Q4+o0Fg
X-Gm-Gg: ASbGncu0cHpRGnRysmrwgHsolnBfE5Y4BWge9OPHN2hfYeiA4UM0bn4VnnOt2E6Jy73
 x2L1vPI59GhY4rijHnlcbTltBREvpXLBOr7+xfKwe11a7wGVyOBtdevWiJqVOs6tQUprbBXCO+j
 xskzdBHYpfrQqTW5brHwjb4hjBsARiX1BXPWilg8swZ35To4qgI+eWAESXuqhS7+cEES8toiHge
 8ltDOhsA2/qaN9b0ZWDisw892dib6pnbCgkdGNNiYyzSNlxdA7fya3ryh1ZZqNyDkqSH0Feh59l
 r/SSV+H/b9LjFcwx3AX6hvsk2T5fDqRXck1vs5OhGkCez/nmuCnLR7JaD/rmkG4=
X-Received: by 2002:a05:600c:35d6:b0:439:985b:17d6 with SMTP id
 5b1f17b1804b1-43ab903603emr23927985e9.27.1740572947511; 
 Wed, 26 Feb 2025 04:29:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOqU6+YvkXlQ4vuTagbuCtwCjwmj0H5+Xta6YoRzeguoUafKp6W738/ohg4cf/c9smG6tt4g==
X-Received: by 2002:a05:600c:35d6:b0:439:985b:17d6 with SMTP id
 5b1f17b1804b1-43ab903603emr23927655e9.27.1740572947018; 
 Wed, 26 Feb 2025 04:29:07 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5711dfsm19946945e9.27.2025.02.26.04.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 04:29:06 -0800 (PST)
Date: Wed, 26 Feb 2025 13:29:05 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, Philippe =?UTF-8?B?TWF0?=
 =?UTF-8?B?aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Eric Blake
 <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, "Markus Armbruster" <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, "Paolo Bonzini" <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, <kvm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 00/14] Change ghes to use HEST-based offsets and add
 support for error inject
Message-ID: <20250226132905.47aa50d2@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250226105628.7e60f952@foz.lan>
References: <cover.1738345063.git.mchehab+huawei@kernel.org>
 <20250203110934.000038d8@huawei.com>
 <20250203162236.7d5872ff@imammedo.users.ipa.redhat.com>
 <20250221073823.061a1039@foz.lan>
 <20250221102127.000059e6@huawei.com>
 <20250225110115.6090e416@imammedo.users.ipa.redhat.com>
 <20250226105628.7e60f952@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 26 Feb 2025 10:56:28 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Tue, 25 Feb 2025 11:01:15 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Fri, 21 Feb 2025 10:21:27 +0000
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >   
> > > On Fri, 21 Feb 2025 07:38:23 +0100
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > >     
> > > > Em Mon, 3 Feb 2025 16:22:36 +0100
> > > > Igor Mammedov <imammedo@redhat.com> escreveu:
> > > >       
> > > > > On Mon, 3 Feb 2025 11:09:34 +0000
> > > > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > > > >         
> > > > > > On Fri, 31 Jan 2025 18:42:41 +0100
> > > > > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > > > >           
> > > > > > > Now that the ghes preparation patches were merged, let's add support
> > > > > > > for error injection.
> > > > > > > 
> > > > > > > On this series, the first 6 patches chang to the math used to calculate offsets at HEST
> > > > > > > table and hardware_error firmware file, together with its migration code. Migration tested
> > > > > > > with both latest QEMU released kernel and upstream, on both directions.
> > > > > > > 
> > > > > > > The next patches add a new QAPI to allow injecting GHESv2 errors, and a script using such QAPI
> > > > > > >    to inject ARM Processor Error records.
> > > > > > > 
> > > > > > > If I'm counting well, this is the 19th submission of my error inject patches.            
> > > > > > 
> > > > > > Looks good to me. All remaining trivial things are in the category
> > > > > > of things to consider only if you are doing another spin.  The code
> > > > > > ends up how I'd like it at the end of the series anyway, just
> > > > > > a question of the precise path to that state!          
> > > > > 
> > > > > if you look at series as a whole it's more or less fine (I guess you
> > > > > and me got used to it)
> > > > > 
> > > > > however if you take it patch by patch (as if you've never seen it)
> > > > > ordering is messed up (the same would apply to everyone after a while
> > > > > when it's forgotten)
> > > > > 
> > > > > So I'd strongly suggest to restructure the series (especially 2-6/14).
> > > > > re sum up my comments wrt ordering:
> > > > > 
> > > > > 0  add testcase for HEST table with current HEST as expected blob
> > > > >    (currently missing), so that we can be sure that we haven't messed
> > > > >    existing tables during refactoring.        
> > > 
> > > To potentially save time I think Igor is asking that before you do anything
> > > at all you plug the existing test hole which is that we don't test HEST
> > > at all.   Even after this series I think we don't test HEST.  You add
> > > a stub hest and exclusion but then in patch 12 the HEST stub is deleted whereas
> > > it should be replaced with the example data for the test.    
> > 
> > that's what I was saying.
> > HEST table should be in DSDT, but it's optional and one has to use
> > 'ras=on' option to enable that, which we aren't doing ATM.
> > So whatever changes are happening we aren't seeing them in tests
> > nor will we see any regression for the same reason.
> > 
> > While white listing tables before change should happen and then updating them
> > is the right thing to do, it's not sufficient since none of tests
> > run with 'ras' enabled, hence code is not actually executed.   
> 
> Ok. Well, again we're not modifying HEST table structure on this
> changeset. The only change affecting HEST is when the number of entries
> increased from 1 to 2.
> 
> Now, looking at bios-tables-test.c, if I got it right, I should be doing
> something similar to the enclosed patch, right?
> 
> If so, I have a couple of questions:
> 
> 1. from where should I get the HEST table? dumping the table from the
>    running VM?


> 
> 2. what values should I use to fill those variables:
> 
> 	int hest_offset = 40 /* HEST */;
> 	int hest_entry_size = 4;
you don't need to do that,
bios-tables-test will dump all ACPI tables for you automatically,
you only need to add or extend a test with ras=on option.

   1: 1st add empty table and whitelist it ("tests/data/acpi/aarch64/virt/HEST")
   2: enable ras in existing tescase

--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2123,7 +2123,8 @@ static void test_acpi_aarch64_virt_tcg(void)
     data.smbios_cpu_max_speed = 2900;
     data.smbios_cpu_curr_speed = 2700;
     test_acpi_one("-cpu cortex-a57 "
-                  "-smbios type=4,max-speed=2900,current-speed=2700", &data);
+                  "-smbios type=4,max-speed=2900,current-speed=2700 "
+                  "-machine ras=on", &data);
     free_test_data(&data);
 }
     
  then with installed IASL run
    V=1 QTEST_QEMU_BINARY=./qemu-system-aarch64  ./tests/qtest/bios-tables-test
  to see diff

  3: rebuild tables and follow the rest of procedure to update expected blobs
     as described in comment at the top of (tests/qtest/bios-tables-test.c)

I'd recommend to add 3 patches as the beginning of the series,
that way we can be sure that if something changes unintentionally
it won't go unnoticed.

> 
> >   
> > > 
> > > That indeed doesn't address testing the error data storage which would be
> > > a different problem.    
> > 
> > I'd skip hardware_errors/CPER testing from QEMU unit tests.
> > That's basically requires functioning 'APEI driver' to test that.
> > 
> > Maybe we can use Ani's framework to parse HEST and all the way
> > towards CPER record(s) traversal, but that's certainly out of
> > scope of this series.
> > It could be done on top, but I won't insist even on that
> > since Mauro's out of tree error injection testing will
> > cover that using actual guest (which I assume he would
> > like to run periodically).  
> 
> Yeah, my plan is to periodically test it. I intend to setup somewhere
> a CI to test Kernel, QEMU and rasdaemon altogether.
> 
> Thanks,
> Mauro
> 
> ---
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 0a333ec43536..31e69d906db4 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -210,6 +210,8 @@ static void test_acpi_fadt_table(test_data *data)
>      uint32_t val;
>      int dsdt_offset = 40 /* DSDT */;
>      int dsdt_entry_size = 4;
> +    int hest_offset = 40 /* HEST */;
> +    int hest_entry_size = 4;
>  
>      g_assert(compare_signature(&table, "FACP"));
>  
> @@ -242,6 +244,12 @@ static void test_acpi_fadt_table(test_data *data)
>      /* update checksum */
>      fadt_aml[9 /* Checksum */] = 0;
>      fadt_aml[9 /* Checksum */] -= acpi_calc_checksum(fadt_aml, fadt_len);
> +
> +
> +
> +    acpi_fetch_table(data->qts, &table.aml, &table.aml_len,
> +                     fadt_aml + hest_offset, hest_entry_size, "HEST", true);
> +    g_array_append_val(data->tables, table);
>  }
>  
>  static void dump_aml_files(test_data *data, bool rebuild)
> @@ -2411,7 +2419,7 @@ static void test_acpi_aarch64_virt_oem_fields(void)
>      };
>      char *args;
>  
> -    args = test_acpi_create_args(&data, "-cpu cortex-a57 "OEM_TEST_ARGS);
> +    args = test_acpi_create_args(&data, "-ras on -cpu cortex-a57 "OEM_TEST_ARGS);
>      data.qts = qtest_init(args);
>      test_acpi_load_tables(&data);
>      test_oem_fields(&data);
> 


