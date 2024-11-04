Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4512BD1BDC1
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 16:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7zW2-00067J-GM; Mon, 04 Nov 2024 11:01:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t7zW1-000672-CM
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:01:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t7zVy-0006zp-TI
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 11:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730736073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=glyKfzkfyvJXA7/ay+ru80n7y82wopZiq4LC3nJhYrU=;
 b=M7DuM4k8H3ht78Hqr5sKBrd93RzN5gzC8MJBJ52UoWfsG+aMh9nSQrmXjFkFc9oRLIULfQ
 VSxGg3ZWKkUQNszVe9b/cUHupbjlkDNN7i3XyWU20ri8YaQQuKKtNZpLGXC0FdcxO9iNp/
 59YxtN9GRtrq963Ux+BYL9/IsSf4VIE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-sFf5ECgwO4Ka7hk4C7pAcQ-1; Mon, 04 Nov 2024 11:01:12 -0500
X-MC-Unique: sFf5ECgwO4Ka7hk4C7pAcQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315544642eso32351775e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 08:01:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730736069; x=1731340869;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=glyKfzkfyvJXA7/ay+ru80n7y82wopZiq4LC3nJhYrU=;
 b=K42MYTP2zI0uG/1a30UI7U31s35eeJLxIyybIf8Q32H5AdkgcIoZe5CoJ9ZGNBVq1v
 rYhU3Bu3GkT34f1sZ7w/2Kun8nXPpRjix+uvmEdJIzObSprW1EoAE+Spj2RqDVtRmj0n
 SFCXpUuFvjKcoQBcHXIeadAUVuyP7GYtLLEhMmmZQIzGP8xvAYUrWIo4lj5z4/+qM5J7
 bzSFpXgCJSngi2NDtVV8po0+1F4n3RkNVumUxsNRW58FeQgCABP2fhHlR7LP0N6KNzJ4
 VIXAm9145Zgw1Z6JA3wwiPOIwVJ9YKK6lMzIPGIAfw68uZMSGJTfkeaXNU5228hAoV22
 Gn7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTKkNRqDE3V0ut0b3xXKrFpsjuu9N3O8npYUS2MTR62OkNOKuYh45w918CB4P5ynp4JJWbKEdjpXvM@nongnu.org
X-Gm-Message-State: AOJu0YxTVzUfwqN10Swd9TOWWuCm3XiDrtS3BJX0T5MCRP9WCQEyl0HV
 KZTijfFIdmgolAbWyl7wuQhPap7iGlE5vCRMktBfDSjDf2AM8CEkJ73Av5Wd/PRlXJh2EN7hdHm
 yZXbO5HC1RmIrLGejMYNbFeIJigd8JLYAtQLTNktOShTsk3vCwszu
X-Received: by 2002:a05:600c:511f:b0:42f:4f6:f8bc with SMTP id
 5b1f17b1804b1-4327b6fd459mr145928985e9.9.1730736068628; 
 Mon, 04 Nov 2024 08:01:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+FtZnSp9FyS3QfLbt5RRa1dgWpqlgrecSI/3rjVwzRzw61tu/+nDVm82KxzMkMNkxbrb3mQ==
X-Received: by 2002:a05:600c:511f:b0:42f:4f6:f8bc with SMTP id
 5b1f17b1804b1-4327b6fd459mr145928485e9.9.1730736068142; 
 Mon, 04 Nov 2024 08:01:08 -0800 (PST)
Received: from redhat.com ([2a02:14f:177:aecb:5a54:cf63:d69d:19ea])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9a9a53sm186721365e9.30.2024.11.04.08.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 08:01:06 -0800 (PST)
Date: Mon, 4 Nov 2024 11:00:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: imammedo@redhat.com, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, ankita@nvidia.com, linuxarm@huawei.com,
 linux-cxl@vger.kernel.org, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, eduardo@habkost.net,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v6 14/15] bios-tables-test: Add complex SRAT / HMAT test
 for GI GP
Message-ID: <20241104110025-mutt-send-email-mst@kernel.org>
References: <20240916171017.1841767-1-Jonathan.Cameron@huawei.com>
 <20240916174449.1843258-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916174449.1843258-1-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 16, 2024 at 06:44:49PM +0100, Jonathan Cameron wrote:
> Add a test with 6 nodes to exercise most interesting corner cases of SRAT
> and HMAT generation including the new Generic Initiator and Generic Port
> Affinity structures.  More details of the set up in the following patch
> adding the table data.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


I could not yet figure out why, but it fails on i686 (32 bit):

https://gitlab.com/mstredhat/qemu/-/jobs/8262608614

any idea?

> ---
>  tests/qtest/bios-tables-test.c | 97 ++++++++++++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 36e5c0adde..f568c4a21c 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1910,6 +1910,101 @@ static void test_acpi_q35_tcg_acpi_hmat_noinitiator(void)
>      free_test_data(&data);
>  }
>  
> +/* Test intended to hit corner cases of SRAT and HMAT */
> +static void test_acpi_q35_tcg_acpi_hmat_generic_x(void)
> +{
> +    test_data data = {};
> +
> +    data.machine = MACHINE_Q35;
> +    data.arch    = "x86";
> +    data.variant = ".acpihmat-generic-x";
> +    test_acpi_one(" -machine hmat=on,cxl=on"
> +                  " -smp 3,sockets=3"
> +                  " -m 128M,maxmem=384M,slots=2"
> +                  " -device pcie-root-port,chassis=1,id=pci.1"
> +                  " -device pci-testdev,bus=pci.1,"
> +                  "multifunction=on,addr=00.0"
> +                  " -device pci-testdev,bus=pci.1,addr=00.1"
> +                  " -device pci-testdev,bus=pci.1,id=gidev,addr=00.2"
> +                  " -device pxb-cxl,bus_nr=64,bus=pcie.0,id=cxl.1"
> +                  " -object memory-backend-ram,size=64M,id=ram0"
> +                  " -object memory-backend-ram,size=64M,id=ram1"
> +                  " -numa node,nodeid=0,cpus=0,memdev=ram0"
> +                  " -numa node,nodeid=1"
> +                  " -object acpi-generic-initiator,id=gi0,pci-dev=gidev,node=1"
> +                  " -numa node,nodeid=2"
> +                  " -object acpi-generic-port,id=gp0,pci-bus=cxl.1,node=2"
> +                  " -numa node,nodeid=3,cpus=1"
> +                  " -numa node,nodeid=4,memdev=ram1"
> +                  " -numa node,nodeid=5,cpus=2"
> +                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
> +                  "data-type=access-latency,latency=10"
> +                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=800M"
> +                  " -numa hmat-lb,initiator=0,target=2,hierarchy=memory,"
> +                  "data-type=access-latency,latency=100"
> +                  " -numa hmat-lb,initiator=0,target=2,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=200M"
> +                  " -numa hmat-lb,initiator=0,target=4,hierarchy=memory,"
> +                  "data-type=access-latency,latency=100"
> +                  " -numa hmat-lb,initiator=0,target=4,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=200M"
> +                  " -numa hmat-lb,initiator=0,target=5,hierarchy=memory,"
> +                  "data-type=access-latency,latency=200"
> +                  " -numa hmat-lb,initiator=0,target=5,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=400M"
> +                  " -numa hmat-lb,initiator=1,target=0,hierarchy=memory,"
> +                  "data-type=access-latency,latency=500"
> +                  " -numa hmat-lb,initiator=1,target=0,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=100M"
> +                  " -numa hmat-lb,initiator=1,target=2,hierarchy=memory,"
> +                  "data-type=access-latency,latency=50"
> +                  " -numa hmat-lb,initiator=1,target=2,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=400M"
> +                  " -numa hmat-lb,initiator=1,target=4,hierarchy=memory,"
> +                  "data-type=access-latency,latency=50"
> +                  " -numa hmat-lb,initiator=1,target=4,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=800M"
> +                  " -numa hmat-lb,initiator=1,target=5,hierarchy=memory,"
> +                  "data-type=access-latency,latency=500"
> +                  " -numa hmat-lb,initiator=1,target=5,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=100M"
> +                  " -numa hmat-lb,initiator=3,target=0,hierarchy=memory,"
> +                  "data-type=access-latency,latency=20"
> +                  " -numa hmat-lb,initiator=3,target=0,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=400M"
> +                  " -numa hmat-lb,initiator=3,target=2,hierarchy=memory,"
> +                  "data-type=access-latency,latency=80"
> +                  " -numa hmat-lb,initiator=3,target=2,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=200M"
> +                  " -numa hmat-lb,initiator=3,target=4,hierarchy=memory,"
> +                  "data-type=access-latency,latency=80"
> +                  " -numa hmat-lb,initiator=3,target=4,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=200M"
> +                  " -numa hmat-lb,initiator=3,target=5,hierarchy=memory,"
> +                  "data-type=access-latency,latency=20"
> +                  " -numa hmat-lb,initiator=3,target=5,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=400M"
> +                  " -numa hmat-lb,initiator=5,target=0,hierarchy=memory,"
> +                  "data-type=access-latency,latency=20"
> +                  " -numa hmat-lb,initiator=5,target=0,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=400M"
> +                  " -numa hmat-lb,initiator=5,target=2,hierarchy=memory,"
> +                  "data-type=access-latency,latency=80"
> +                  " -numa hmat-lb,initiator=5,target=4,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=200M"
> +                  " -numa hmat-lb,initiator=5,target=4,hierarchy=memory,"
> +                  "data-type=access-latency,latency=80"
> +                  " -numa hmat-lb,initiator=5,target=2,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=200M"
> +                  " -numa hmat-lb,initiator=5,target=5,hierarchy=memory,"
> +                  "data-type=access-latency,latency=10"
> +                  " -numa hmat-lb,initiator=5,target=5,hierarchy=memory,"
> +                  "data-type=access-bandwidth,bandwidth=800M",
> +                  &data);
> +    free_test_data(&data);
> +}
> +
>  #ifdef CONFIG_POSIX
>  static void test_acpi_erst(const char *machine, const char *arch)
>  {
> @@ -2388,6 +2483,8 @@ int main(int argc, char *argv[])
>              qtest_add_func("acpi/q35/nohpet", test_acpi_q35_tcg_nohpet);
>              qtest_add_func("acpi/q35/acpihmat-noinitiator",
>                             test_acpi_q35_tcg_acpi_hmat_noinitiator);
> +            qtest_add_func("acpi/q35/acpihmat-genericx",
> +                           test_acpi_q35_tcg_acpi_hmat_generic_x);
>  
>              /* i386 does not support memory hotplug */
>              if (strcmp(arch, "i386")) {
> -- 
> 2.43.0


