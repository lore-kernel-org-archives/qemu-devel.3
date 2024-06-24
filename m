Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA06BC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 23:08:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLsmS-0004kl-Kk; Mon, 24 Jun 2024 19:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLsmQ-0004jB-Sg
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 19:07:22 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLsmO-0007HP-UX
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 19:07:22 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2c85ca2dc5cso1350741a91.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 16:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719270439; x=1719875239; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1pYj7UAWjaFYE6py7YstfU56Zf2I3BdkqqTvU1WuzDM=;
 b=dz/eDDlj4lCnWv1i0q8Bx+0mNanCYNgQ+qMNSSe6R2F7FgUAmmosTLA/2nhCK9JrS6
 YuosuxR7D1KBO7/Bj+UdzCbDVHYnTwHH0jUe9RdbjJdLpAcJlIPYhizhNu/AtWEU5glh
 43wOQcml6XDkc9Lies5uHkczQdJaStEBRhZ+6jF41BOADUxiLGMd8Vm8/xrNrHTxjhvD
 iifQAmIX/FOkiVQLc9V6xQByIQVr64b5xOLh44JCC+yA7AjnkNhHnVpXUcUJjl1NwJh9
 HESQ22gG2O/ABoX3qRsnpSKTj7yFNgXGzuO0Yj29+M8wkNK96DF69rvEtfYLYNyW/4VN
 PQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719270439; x=1719875239;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1pYj7UAWjaFYE6py7YstfU56Zf2I3BdkqqTvU1WuzDM=;
 b=VzK073V5bRpCe4/jSDFkxQsK+xtnhueZdymk/b8pBm0xDg+b52yAHfODy5SUI5gEbW
 347jxCmY6eRT8BC0LtqD9hiKmvbOnm5PEIVopLvOujH/acD2tcuWRM9nwEz8MYasDCAo
 3rJi3gp2GEMagC7AHntBIJRs5Up5Opz83cxdWASiY36nKJN/Q6Z3mJoaNQNBHTVt68oJ
 p1YxBef3qcJe37U8g9xzHpUQsmIzso9fx2gT/Z3Qe1UtApzStIldKcILLF62zSGRyKlA
 eJa1rNa4oH2RKVY+Jee914Sg04fUkTCU+OkmXpcFid7nPqIT7XtZBWLwpf+VSlOsRCZ2
 0Ofg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV47KdVo8ZblgKWNZglRth2rCT6hQbm42vn+kOaFTA6agNgvSahP52DGCBE3DdbaPSLeuVbngTQCkOlS+fordigGKrQIAU=
X-Gm-Message-State: AOJu0YxlbKfA5dA7eTPV/AoUmK9RZ6Pto+Vk+How4JhMwx8+aiUDWZoY
 4Y2AR8EJmQFVSCGEgsseDDm+rAyxwjSIJYY3vl4WzqxNDnlvonkVMwooKm94dE4=
X-Google-Smtp-Source: AGHT+IG4OAj+uvZEBiO6FUyAgxgH7qpsiWx87Wm8APUVUPQalwKhU1in9WhIngpSKB1dUmdHms3v6A==
X-Received: by 2002:a17:90b:1e0a:b0:2c7:cd4f:d765 with SMTP id
 98e67ed59e1d1-2c848a5a2e8mr8637747a91.21.1719270438566; 
 Mon, 24 Jun 2024 16:07:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c8499c4761sm5064308a91.30.2024.06.24.16.07.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 16:07:18 -0700 (PDT)
Message-ID: <91f19b8d-387a-47cd-b7cc-19cdf4442473@linaro.org>
Date: Mon, 24 Jun 2024 16:07:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 30/45] i386/sev: Add handling to encrypt/finalize guest
 launch data
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Brijesh Singh <brijesh.singh@amd.com>, Michael Roth
 <michael.roth@amd.com>, Pankaj Gupta <pankaj.gupta@amd.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
 <20240604064409.957105-31-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240604064409.957105-31-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/3/24 23:43, Paolo Bonzini wrote:
> From: Brijesh Singh <brijesh.singh@amd.com>
> 
> Process any queued up launch data and encrypt/measure it into the SNP
> guest instance prior to initial guest launch.
> 
> This also updates the KVM_SEV_SNP_LAUNCH_UPDATE call to handle partial
> update responses.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Co-developed-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Co-developed-by: Pankaj Gupta <pankaj.gupta@amd.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
> Message-ID: <20240530111643.1091816-17-pankaj.gupta@amd.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/sev.c        | 112 ++++++++++++++++++++++++++++++++++++++-
>   target/i386/trace-events |   2 +
>   2 files changed, 113 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index e89b87d2f55..ef2e592ca76 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -756,6 +756,76 @@ out:
>       return ret;
>   }
>   
> +static const char *
> +snp_page_type_to_str(int type)
> +{
> +    switch (type) {
> +    case KVM_SEV_SNP_PAGE_TYPE_NORMAL: return "Normal";
> +    case KVM_SEV_SNP_PAGE_TYPE_ZERO: return "Zero";
> +    case KVM_SEV_SNP_PAGE_TYPE_UNMEASURED: return "Unmeasured";
> +    case KVM_SEV_SNP_PAGE_TYPE_SECRETS: return "Secrets";
> +    case KVM_SEV_SNP_PAGE_TYPE_CPUID: return "Cpuid";
> +    default: return "unknown";
> +    }
> +}
> +
> +static int
> +sev_snp_launch_update(SevSnpGuestState *sev_snp_guest,
> +                      SevLaunchUpdateData *data)
> +{
> +    int ret, fw_error;
> +    struct kvm_sev_snp_launch_update update = {0};
> +
> +    if (!data->hva || !data->len) {
> +        error_report("SNP_LAUNCH_UPDATE called with invalid address"
> +                     "/ length: %p / %lx",
> +                     data->hva, data->len);

This patch does not compile on 32-bit x86:

../src/target/i386/sev.c: In function 'sev_snp_launch_update':
../src/target/i386/sev.c:886:22: error: format '%lx' expects argument of type 'long 
unsigned int', but argument 3 has type 'uint64_t' {aka 'long long unsigned int'} 
[-Werror=format=]
   886 |         error_report("SNP_LAUNCH_UPDATE called with invalid address"
       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   887 |                      "/ length: %p / %lx",
   888 |                      data->hva, data->len);
       |                                 ~~~~~~~~~
       |                                     |
       |                                     uint64_t {aka long long unsigned int}
../src/target/i386/sev.c:935:22: error: format '%lx' expects argument of type 'long 
unsigned int', but argument 2 has type 'hwaddr' {aka 'long long unsigned int'} 
[-Werror=format=]
   935 |         error_report("SEV-SNP: expected update of GPA range %lx-%lx,"
       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   936 |                      "got GPA range %lx-%llx",
   937 |                      data->gpa, data->gpa + data->len, data->gpa,
       |                      ~~~~~~~~~
       |                          |
       |                          hwaddr {aka long long unsigned int}
../src/target/i386/sev.c:935:22: error: format '%lx' expects argument of type 'long 
unsigned int', but argument 3 has type 'long long unsigned int' [-Werror=format=]
   935 |         error_report("SEV-SNP: expected update of GPA range %lx-%lx,"
       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   936 |                      "got GPA range %lx-%llx",
   937 |                      data->gpa, data->gpa + data->len, data->gpa,
       |                                 ~~~~~~~~~~~~~~~~~~~~~
       |                                           |
       |                                           long long unsigned int
../src/target/i386/sev.c:935:22: error: format '%lx' expects argument of type 'long 
unsigned int', but argument 4 has type 'hwaddr' {aka 'long long unsigned int'} 
[-Werror=format=]
   935 |         error_report("SEV-SNP: expected update of GPA range %lx-%lx,"
       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   936 |                      "got GPA range %lx-%llx",
   937 |                      data->gpa, data->gpa + data->len, data->gpa,
       |                                                        ~~~~~~~~~
       |                                                            |
       |                                                            hwaddr {aka long long 
unsigned int}
In file included from ../src/target/i386/sev.c:22:
../src/target/i386/sev.c: In function 'sev_snp_guest_set_guest_visible_workarounds':
/home/rth/qemu/src/include/qapi/error.h:319:25: error: format '%lu' expects argument of 
type 'long unsigned int', but argument 6 has type 'gsize' {aka 'unsigned int'} 
[-Werror=format=]
   319 |                         (fmt), ## __VA_ARGS__)
       |                         ^~~~~
../src/target/i386/sev.c:2149:9: note: in expansion of macro 'error_setg'
  2149 |         error_setg(errp, "parameter length of %lu exceeds max of %lu",
       |         ^~~~~~~~~~
/home/rth/qemu/src/include/qapi/error.h:319:25: error: format '%lu' expects argument of 
type 'long unsigned int', but argument 7 has type 'unsigned int' [-Werror=format=]
   319 |                         (fmt), ## __VA_ARGS__)
       |                         ^~~~~
../src/target/i386/sev.c:2149:9: note: in expansion of macro 'error_setg'
  2149 |         error_setg(errp, "parameter length of %lu exceeds max of %lu",
       |         ^~~~~~~~~~
../src/target/i386/sev.c: In function 'sev_snp_guest_set_id_block':
../src/target/i386/sev.c:2174:12: error: cast to pointer from integer of different size 
[-Werror=int-to-pointer-cast]
  2174 |     g_free((guchar *)finish->id_block_uaddr);
       |            ^
../src/target/i386/sev.c:2180:9: error: cast from pointer to integer of different size 
[-Werror=pointer-to-int-cast]
  2180 |         (uint64_t)qbase64_decode(sev_snp_guest->id_block, -1, &len, errp);
       |         ^
/home/rth/qemu/src/include/qapi/error.h:319:25: error: format '%lu' expects argument of 
type 'long unsigned int', but argument 6 has type 'gsize' {aka 'unsigned int'} 
[-Werror=format=]
   319 |                         (fmt), ## __VA_ARGS__)
       |                         ^~~~~
../src/target/i386/sev.c:2187:9: note: in expansion of macro 'error_setg'
  2187 |         error_setg(errp, "parameter length of %lu not equal to %u",
       |         ^~~~~~~~~~
../src/target/i386/sev.c: In function 'sev_snp_guest_set_id_auth':
../src/target/i386/sev.c:2211:12: error: cast to pointer from integer of different size 
[-Werror=int-to-pointer-cast]
  2211 |     g_free((guchar *)finish->id_auth_uaddr);
       |            ^
../src/target/i386/sev.c:2217:9: error: cast from pointer to integer of different size 
[-Werror=pointer-to-int-cast]
  2217 |         (uint64_t)qbase64_decode(sev_snp_guest->id_auth, -1, &len, errp);
       |         ^
/home/rth/qemu/src/include/qapi/error.h:319:25: error: format '%lu' expects argument of 
type 'long unsigned int', but argument 6 has type 'gsize' {aka 'unsigned int'} 
[-Werror=format=]
   319 |                         (fmt), ## __VA_ARGS__)
       |                         ^~~~~
../src/target/i386/sev.c:2224:9: note: in expansion of macro 'error_setg'
  2224 |         error_setg(errp, "parameter length:ID_AUTH %lu exceeds max of %u",
       |         ^~~~~~~~~~
../src/target/i386/sev.c: In function 'sev_snp_guest_set_host_data':
/home/rth/qemu/src/include/qapi/error.h:319:25: error: format '%lu' expects argument of 
type 'long unsigned int', but argument 6 has type 'gsize' {aka 'unsigned int'} 
[-Werror=format=]
   319 |                         (fmt), ## __VA_ARGS__)
       |                         ^~~~~
../src/target/i386/sev.c:2290:9: note: in expansion of macro 'error_setg'
  2290 |         error_setg(errp, "parameter length of %lu not equal to %lu",
       |         ^~~~~~~~~~
/home/rth/qemu/src/include/qapi/error.h:319:25: error: format '%lu' expects argument of 
type 'long unsigned int', but argument 7 has type 'unsigned int' [-Werror=format=]
   319 |                         (fmt), ## __VA_ARGS__)
       |                         ^~~~~
../src/target/i386/sev.c:2290:9: note: in expansion of macro 'error_setg'
  2290 |         error_setg(errp, "parameter length of %lu not equal to %lu",
       |         ^~~~~~~~~~
cc1: all warnings being treated as errors
ninja: build stopped: subcommand failed.


r~


