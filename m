Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60346CA0EC4
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 18:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ultTU-0005KZ-Lh; Tue, 12 Aug 2025 14:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ultTQ-0005JR-6q
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 14:11:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ultTJ-0001OJ-VR
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 14:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755022296;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jvantC9dptGQv+KLO5vBkgTqqNEYgjZbMxvKoSj+TMk=;
 b=O5V/fof7n3zZsCOFFKTcVLkFEqGljEwy1rNI7vxFuKMmIWgXM7qzUEATEhZS/7rgaqoB+B
 Zp0FreWNZnP/ychgIY9ebVHR12DVU4N9FU2J21ERqed8WGdud5G1EVqJWAYi3q9YNK+XGt
 DnzA0s8McMus+CTdtwcgP0RLd1KDpqI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-VEIyn5kQOIynXvqFYqztzA-1; Tue, 12 Aug 2025 14:11:34 -0400
X-MC-Unique: VEIyn5kQOIynXvqFYqztzA-1
X-Mimecast-MFC-AGG-ID: VEIyn5kQOIynXvqFYqztzA_1755022294
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7e86499748cso28269385a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 11:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755022294; x=1755627094;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jvantC9dptGQv+KLO5vBkgTqqNEYgjZbMxvKoSj+TMk=;
 b=EXU65R/9b6qik/HrqMKaeCNJgr5KeidGxrj6RNnCKQsuIfXlLVi1/7i8b/QRCHRfxz
 tG3RCLsnYaMSuLuWGgiz/j5h+s3AYXRn2DStI+HEBw1nX/QIWBoz5XQsB0s1DDG8H+Jy
 b1Khp5KTYdHd/SIVG54jzy5aN1wWojtR58QcNosziw2w29zlFrrj9gQ38XcBlg/jX6G7
 D402C4fo7Jw6Ng6kXssfhveLNQwwvrSJZqrEsIpYUiZLECuVv+/Ptwd818OL4UUg+YD2
 W3Z5KxuosObI9knMvxDOqGz2KA8h1yAkD1y3hWoCCtrXMsulW953MWAL6nLGUedHpztf
 SDeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXKeJtapVZ6oKZ89PQDORr9LMFL99vWkuI9DGis0uobrI6WTHsSWprCWw5rySs/8Hfws3rBoO6uIdc@nongnu.org
X-Gm-Message-State: AOJu0YwItUxd6PaeBTwWhKUTSTCJOZnNribfNisZfRt4MX//fe9n0Y+T
 AMYTbDAuWVFAm4SMrl9M8eSeqRCXP1sSw2qLFY7y0DdLy195rPTXtG6SmcziwDDm4HXLXIkRsTe
 E4SKAAhNCYwQgTR+87p6YbBmt9K6a9L6uNylLmk1BWTOUtRC2UE2n/5Rq
X-Gm-Gg: ASbGncsVwN2V2M7sYELvA7sUI+iw72H7gW0htwKv3ymvE97uOWPhlB+nCIm5x+3kDmC
 AD+4ot0k2w8j5ifoT7YnmQQ9Uv4JCxjS2j3Z/ndMIY3eH3ewXlvw3gs/quGSaxz5bHDtFLc01Iz
 3eaNCzZqcdnM+UNMowORfbMfqsp27PU21TMcpWA8iqB6mIm3cu6iAt2IDUVVqcTaBmX3POHhOUt
 0JvXEkUZqa+p9AOHdF4tJadFSBDKRdosFZLbZ836MpFQ+TN04HCLE0YnPef1+lRpLsC8UZ6nAL6
 tQYG/0bl7oNYyVJjfqZqqtpZZRBszC8Ll6gXIhdtOF2ss4CHI35P49KL6XlFTeoH4SJDomA49jo
 ESAle6Y7Sdzg=
X-Received: by 2002:a05:620a:1919:b0:7e8:161:e633 with SMTP id
 af79cd13be357-7e864ab92a3mr59121685a.5.1755022294170; 
 Tue, 12 Aug 2025 11:11:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvZTpvPOyqK3fI3rXoL9ASFeWp0ZWgnWKF/CSbIUc1Ouwd8CMpj8hOhpC3/YYW7ISTz00G7g==
X-Received: by 2002:a05:620a:1919:b0:7e8:161:e633 with SMTP id
 af79cd13be357-7e864ab92a3mr59118485a.5.1755022293697; 
 Tue, 12 Aug 2025 11:11:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e7fc4db4bdsm1396500385a.28.2025.08.12.11.11.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 11:11:33 -0700 (PDT)
Message-ID: <88812eea-08e3-48f5-b2f8-75ab0fff573b@redhat.com>
Date: Tue, 12 Aug 2025 20:11:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] arm/kvm: report registers we failed to set
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20250721161932.548668-1-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250721161932.548668-1-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Connie,

On 7/21/25 6:19 PM, Cornelia Huck wrote:
> If we fail migration because of a mismatch of some registers between
> source and destination, the error message is not very informative:
>
> qemu-system-aarch64: error while loading state for instance 0x0 ofdevice 'cpu'
> qemu-system-aarch64: Failed to put registers after init: Invalid argument
>
> At least try to give the user a hint which registers had a problem,
> even if they cannot really do anything about it right now.
>
> Sample output:
>
> Could not set register op0:3 op1:0 crn:0 crm:0 op2:0 to c00fac31 (is 413fd0c1)
>
> We could be even more helpful once we support writable ID registers,
> at which point the user might actually be able to configure something
> that is migratable.
>
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>
> Notes:
> - This currently prints the list of failing registers for every call to
>   write_list_to_kvmstate(), in particular for every cpu -- we might want
>   to reduce that.
> - If the macros aren't too ugly (or we manage to improve them), there
>   might be other places where they could be useful.
>
> ---
>  target/arm/kvm.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 667234485547..ac6502e0c78f 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -900,6 +900,24 @@ bool write_kvmstate_to_list(ARMCPU *cpu)
>      return ok;
>  }
>  
> +/* pretty-print a KVM register */
> +#define CP_REG_ARM64_SYSREG_OP(_reg, _op)                       \
> +    ((uint8_t)((_reg & CP_REG_ARM64_SYSREG_ ## _op ## _MASK) >> \
> +               CP_REG_ARM64_SYSREG_ ## _op ## _SHIFT))
> +
> +#define PRI_CP_REG_ARM64_SYSREG(_reg)                    \
> +    ({                                                   \
> +        char _out[32];                                   \
> +        snprintf(_out, sizeof(_out),                     \
> +                 "op0:%d op1:%d crn:%d crm:%d op2:%d",   \
> +                 CP_REG_ARM64_SYSREG_OP(_reg, OP0),      \
> +                 CP_REG_ARM64_SYSREG_OP(_reg, OP1),      \
> +                 CP_REG_ARM64_SYSREG_OP(_reg, CRN),      \
> +                 CP_REG_ARM64_SYSREG_OP(_reg, CRM),      \
> +                 CP_REG_ARM64_SYSREG_OP(_reg, OP2));     \
> +        _out;                                            \
> +    })
> +
I am afraid this is too simplistic.
Refering to linux/Documentation/virt/kvm/api.rst 4.68 KVM_SET_ONE_REG
ARM registers section
there are different groups of registers (upper 16b) and not all regs are
further identified by op0-2, crn, crm.
I think it would be valuable to output the group type and then the
formatted lower 16b, depending on the group type.

For instance 64b ARM FW pseudo reg is formatted as
0x6030 0000 0014 <regno:16>

a diff on reg 0 results in
qemu-system-aarch64: Could not set register op0:0 op1:0 crn:0 crm:0
op2:0 to 10003 (is 10001)
qemu-system-aarch64: error while loading state for instance 0x0 of
device 'cpu'
qemu-system-aarch64: Could not set register op0:0 op1:0 crn:0 crm:0
op2:0 to 10003 (is 10001)
qemu-system-aarch64: Failed to put registers after init: Invalid argument

Thanks

Eric
>  bool write_list_to_kvmstate(ARMCPU *cpu, int level)
>  {
>      CPUState *cs = CPU(cpu);
> @@ -932,6 +950,41 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level)
>               * a different value from what it actually contains".
>               */
>              ok = false;
> +            switch (ret) {
> +            case -ENOENT:
> +                error_report("Could not set register %s: unknown to KVM",
> +                             PRI_CP_REG_ARM64_SYSREG(regidx));
> +                break;
> +            case -EINVAL:
> +                if ((regidx & KVM_REG_SIZE_MASK) == KVM_REG_SIZE_U32) {
> +                    if (!kvm_get_one_reg(cs, regidx, &v32)) {
> +                        error_report("Could not set register %s to %x (is %x)",
> +                                     PRI_CP_REG_ARM64_SYSREG(regidx),
> +                                     (uint32_t)cpu->cpreg_values[i], v32);
> +                    } else {
> +                        error_report("Could not set register %s to %x",
> +                                     PRI_CP_REG_ARM64_SYSREG(regidx),
> +                                     (uint32_t)cpu->cpreg_values[i]);
> +                    }
> +                } else /* U64 */ {
> +                    uint64_t v64;
> +
> +                    if (!kvm_get_one_reg(cs, regidx, &v64)) {
> +                        error_report("Could not set register %s to %lx (is %lx)",
> +                                     PRI_CP_REG_ARM64_SYSREG(regidx),
> +                                     cpu->cpreg_values[i], v64);
> +                    } else {
> +                        error_report("Could not set register %s to %lx",
> +                                     PRI_CP_REG_ARM64_SYSREG(regidx),
> +                                     cpu->cpreg_values[i]);
> +                    }
> +                }
> +                break;
> +            default:
> +                error_report("Could not set register %s: %s",
> +                             PRI_CP_REG_ARM64_SYSREG(regidx),
> +                             strerror(-ret));
> +            }
>          }
>      }
>      return ok;


