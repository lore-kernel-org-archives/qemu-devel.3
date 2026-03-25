Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54C8103A9AB
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 11:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5M5U-0000Tg-T3; Wed, 25 Mar 2026 07:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w5M5L-0000RA-Pl; Wed, 25 Mar 2026 07:07:40 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w5M5I-0002Ij-TH; Wed, 25 Mar 2026 07:07:39 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62PB78JM033078
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 25 Mar 2026 20:07:09 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=+n/kMAvjcvgBrn5kSKBwYwfoozOlrY0QV86bOUd6KA0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1774436829; v=1;
 b=bizTiWDJBJfb4r3Av5wvnkGtJqozxnt0HYH8nLYiEATkH7/pbQwcr2YDwwQ6H9EV
 nVXqK+uhFuXXuPXmWgDErogJlQbxHYfoMJ10nfExKo22+bClQYrAMp1fxRZHzt4O
 mNV6qEQoWpsSyC0P+q9Iy6iyTYPeQzeN/O+TYp7zUfNHu9M6MSo576cWY5ptuM7d
 fy68+N/OyKJUMUT2oRheZt+8sr9Dq7jTGaJEgV/gPjes+biWjAgnMhjTh3onbdk7
 d+4XyRF5CRRD1ajjoysADVpX8LOqGBQ1g5VSrRWV+NTmq2+IsODHVPmkwpvBcrOx
 4DD/i0OnNwcTuWdMiAQsVQ==
Message-ID: <9cf3d5c9-32eb-4944-8fbf-4775e1cccecb@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 25 Mar 2026 20:07:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 7/7] hvf: do not merge: enable private ISA
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Alexander Graf <agraf@csgraf.de>
References: <20260324204855.29759-1-mohamed@unpredictable.fr>
 <20260324204855.29759-8-mohamed@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260324204855.29759-8-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/03/25 5:48, Mohamed Mediouni wrote:
> Booting macOS Tahoe.
> 
> There in the series to show that's all it takes, but not
> mergable as is. Testing this requires SIP to be disabled
> and AMFI to be bypassed to be able to launch the executable.


This is interesting. Do you have any idea what is the private ISA?

Regards,
Akihiko Odaki

> 
> Note that macOS Tahoe uses ISV=0, and the corresponding series
> is needed too.
> 
> The script to do so:
> https://gist.githubusercontent.com/zhaofengli/1df11ae3f0dd4e2c872a12ef849f7371/raw/b0ef43f2168600e8810d35a3e70d9a1eb39929e2/amfid-allow.py
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/hvf/entitlements.plist | 2 +-
>   target/arm/hvf/hvf.c         | 8 ++++++++
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/hvf/entitlements.plist b/accel/hvf/entitlements.plist
> index 154f3308ef..b1a25a2319 100644
> --- a/accel/hvf/entitlements.plist
> +++ b/accel/hvf/entitlements.plist
> @@ -2,7 +2,7 @@
>   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
>   <plist version="1.0">
>   <dict>
> -    <key>com.apple.security.hypervisor</key>
> +    <key>com.apple.private.hypervisor</key>
>       <true/>
>   </dict>
>   </plist>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 000e54bd16..5d23aa8ae4 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1219,6 +1219,8 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
>       assert_hvf_ok(ret);
>   }
>   
> +hv_return_t _hv_vm_config_set_isa(hv_vm_config_t cfg, int isa);
> +
>   hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
>   {
>       hv_return_t ret;
> @@ -1230,6 +1232,12 @@ hv_return_t hvf_arch_vm_create(MachineState *ms, uint32_t pa_range)
>       }
>       chosen_ipa_bit_size = pa_range;
>   
> +    ret = _hv_vm_config_set_isa(config, 3);
> +    if (ret != HV_SUCCESS) {
> +        error_report("error setting private ISA");
> +        goto cleanup;
> +    }
> +
>       ret = hv_vm_create(config);
>   
>   cleanup:


