Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E4C1EDEBE0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 19:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxV2H-0005Hg-49; Tue, 03 Mar 2026 14:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxV2F-0005Fw-NW
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:03:59 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxV2D-00042e-DI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 14:03:59 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-82742aa5a3eso2978257b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 11:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772564636; x=1773169436; darn=nongnu.org;
 h=in-reply-to:autocrypt:from:references:cc:to:content-language
 :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jfa0BTJiu0OaoIir1H7GAUKqjehdctranbZAI2qkmio=;
 b=R3nI4KUyj0uZajNwau6tf0kFWh74Gm+/MwgOyL/q69QNQblaDWBmVgJ+VATt9jPamI
 looRUdqv31ljsPSGuQTYzenXwTlBq75D/BMccrxkmg1njuEiln99Dr+gNxlfSTw/NLVF
 IeG7SQIy1KD3iTRGsyOSIwY3msETTS+1jfFwFeVZ8Qa4Lr2i9nQ8i1nkvH0DFFDG8Zv6
 7korcI6yuMAtWQvoBgnJEWeEln2ZqSe+2kv8aeGIDpXvdtgnQqCyU0krJQiXYtsue2In
 MsTsCGteRIRBtLNiYn4Tp+UWxjBnjjybLCyELSqr5w587AkxAFkkuWEMPIK2Mg18cgOL
 1nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772564636; x=1773169436;
 h=in-reply-to:autocrypt:from:references:cc:to:content-language
 :subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jfa0BTJiu0OaoIir1H7GAUKqjehdctranbZAI2qkmio=;
 b=vr0ChV0XwDwfYNI/CgbRu0rPm8T8DALuUpvgq91IVQ7D7ih5BY3ufq+itZWNFXCS+O
 hNdI+Al9jFZJMuY0Xkkb7Bn6gqHCoU2hRQFVMbE1Wc8Qa0YYkY99A3oJi0bCIkbMDmyg
 lGntBdpgmyr3/JL7JHHV+6AYJqLFKxLXRr7BYbKJlBscJ44sNjNmEFluINQULILgYgfW
 mlkn5ARNIxIVghCglINyOzqHv4SH5JL/OyQBxtJD8t+dfpOntet8EJ8QHB2e2SLSPuRs
 Oe77PyH6r1dMXoOhne+Kc4ag+n05gt4g0J4zJaqTHPK95vovH9Qst3YkGD4fJT6AxTjb
 gscA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1ewYsW/HSP6UMe6D8U3Rhps6WntWVR7ztcRIWzf8oJJIUY9S+zo1uEZtImoT2XvzGuOvAm5VkQNWK@nongnu.org
X-Gm-Message-State: AOJu0YwJo9UGgyidlpsLy6i4o2fN5lwyng1VG5aTDdcnDsKW9tXfNYIq
 n26Mv5tZxbT+wgFHAHt2N66gam4oAUOm15Dxpezx8/jozXCdCij7oonNmygL7xnGAkM=
X-Gm-Gg: ATEYQzyd0JUzGM8fnAcro22r5rMUjRuhVNZjefy61S1clLYQzSZMngKUoHftfqonYuB
 0Kf5VNHuQ146nrjPGoZhg20WdG2REctSDw79BPBjQQgySzwbkiu+toTaMXKDAriBQAlAY00PdYU
 hb/3v2rOcjL0X4yDavzev/7p9yO1hqy39Wj225BZeZc7o5wf5rv/vFyzUBJw3p5jeo8e+OnKlGn
 ohjQpMw6XxYpv/I3/cvxL7fpSFMjBl3Xu+8uwRGL4+oPSlactKV70PTn5Gs687tWRhacmTWrGO5
 wFfsv0D5EMXlMVmPQ5ALsl429jqTmkZgydvg+wg7QSYgFH7/R8dP8MdV9euNWVUclFcdWe0py/s
 sCL8ysV49750D003av1Zxk5JQtK9oslyARI8JrSfL5yhKDRqk2Vz+jomJequjLrokaQoQpUyGZO
 FenWr7Pb+x7HpS8inQBrWeL5wYEkxh109MNAcYBDrhDtBNJppgbJ9dny/86fQjp1ookyx8
X-Received: by 2002:a05:6a00:800d:b0:81f:9f14:ecc8 with SMTP id
 d2e1a72fcca58-8274d97ce62mr11711979b3a.27.1772564635625; 
 Tue, 03 Mar 2026 11:03:55 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739d4d93dsm16447461b3a.3.2026.03.03.11.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 11:03:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------wnS9Zj1VrjWIsUrEPuMGuoEI"
Message-ID: <fce1ca77-fdd3-424f-9dff-eef789526fa8@linaro.org>
Date: Tue, 3 Mar 2026 11:03:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 20/28] hvf: i386: save/restore CR0/2/3
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
 <20260223233950.96076-21-mohamed@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260223233950.96076-21-mohamed@unpredictable.fr>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

This is a multi-part message in MIME format.
--------------wnS9Zj1VrjWIsUrEPuMGuoEI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/26 3:39 PM, Mohamed Mediouni wrote:
> For symmetry, save/restore the same set of registers even when not needed.
> 
> CR2 save/restore needed as page faults injected to the guest imply modifying CR2.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/i386/hvf/hvf.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index fb039ff7bd..a70f8461b0 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -477,7 +477,19 @@ static void hvf_load_crs(CPUState *cs)
>   
>       env->cr[0] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR0);
>       env->cr[3] = rvmcs(cpu->accel->fd, VMCS_GUEST_CR3);
> +    env->cr[2] = rreg(cpu->accel->fd, HV_X86_CR2);
>   }
> +
> +static void hvf_save_crs(CPUState *cs)
> +{
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +
> +    wvmcs(cpu->accel->fd, VMCS_GUEST_CR0, env->cr[0]);
> +    wvmcs(cpu->accel->fd, VMCS_GUEST_CR3, env->cr[3]);
> +    wreg(cs->accel->fd, HV_X86_CR2, env->cr[2]);
> +}
> +
>   void hvf_load_regs(CPUState *cs)
>   {
>       X86CPU *cpu = X86_CPU(cs);
> @@ -794,6 +806,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
>               decode_instruction(env, &decode);
>               exec_instruction(env, &decode);
>               hvf_store_regs(cpu);
> +            hvf_save_crs(cpu);
>               break;
>           }
>           break;
> @@ -837,6 +850,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
>           assert(ins_len == decode.len);
>           exec_instruction(env, &decode);
>           hvf_store_regs(cpu);
> +        hvf_save_crs(cpu);
>   
>           break;
>       }
> @@ -942,6 +956,7 @@ static int hvf_handle_vmexit(CPUState *cpu)
>           decode_instruction(env, &decode);
>           exec_instruction(env, &decode);
>           hvf_store_regs(cpu);
> +        hvf_save_crs(cpu);
>           break;
>       }
>       case EXIT_REASON_TPR: {

This patch doesn't compile.
See a fixing patch I'll let you upstream.
I'm a bit puzzled about how this has been tested though.

If you don't have access to a Mac intel based, you can use a 
github-runner for free [1].

[1] https://github.com/second-reality/github-runners

Regards,
Pierrick
--------------wnS9Zj1VrjWIsUrEPuMGuoEI
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-target-i386-hvf-hvf.c-fix-compilation.patch"
Content-Disposition: attachment;
 filename="0001-target-i386-hvf-hvf.c-fix-compilation.patch"
Content-Transfer-Encoding: base64

RnJvbSBlNjE0ZjI1Y2EzMDk1MzgxNWEwYzU5NzAyY2VlYmZiOTQ2NWY4MDMwIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQGxpbmFyby5vcmc+CkRhdGU6IFR1ZSwgMyBNYXIgMjAyNiAxMDo1MTo1NyAtMDgwMApT
dWJqZWN0OiBbUEFUQ0hdIHRhcmdldC9pMzg2L2h2Zi9odmYuYzogZml4IGNvbXBpbGF0aW9u
CgouLi90YXJnZXQvaTM4Ni9odmYvaHZmLmM6NDc2OjMxOiBlcnJvcjogdXNlIG9mIHVuZGVj
bGFyZWQgaWRlbnRpZmllciAnY3B1JwogIDQ3NiB8ICAgICBYODZDUFUgKng4Nl9jcHUgPSBY
ODZfQ1BVKGNwdSk7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgou
Li90YXJnZXQvaTM4Ni9odmYvaHZmLmM6NDc5OjI0OiBlcnJvcjogdXNlIG9mIHVuZGVjbGFy
ZWQgaWRlbnRpZmllciAnY3B1JwogIDQ3OSB8ICAgICBlbnYtPmNyWzBdID0gcnZtY3MoY3B1
LT5hY2NlbC0+ZmQsIFZNQ1NfR1VFU1RfQ1IwKTsKICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgIF4KLi4vdGFyZ2V0L2kzODYvaHZmL2h2Zi5jOjQ4MDoyNDogZXJyb3I6IHVzZSBv
ZiB1bmRlY2xhcmVkIGlkZW50aWZpZXIgJ2NwdScKICA0ODAgfCAgICAgZW52LT5jclszXSA9
IHJ2bWNzKGNwdS0+YWNjZWwtPmZkLCBWTUNTX0dVRVNUX0NSMyk7CiAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgICBeCi4uL3RhcmdldC9pMzg2L2h2Zi9odmYuYzo0ODE6MjM6IGVy
cm9yOiB1c2Ugb2YgdW5kZWNsYXJlZCBpZGVudGlmaWVyICdjcHUnCiAgNDgxIHwgICAgIGVu
di0+Y3JbMl0gPSBycmVnKGNwdS0+YWNjZWwtPmZkLCBIVl9YODZfQ1IyKTsKICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgXgouLi90YXJnZXQvaTM4Ni9odmYvaHZmLmM6NDg2OjMx
OiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAnY3B1JwogIDQ4NiB8ICAg
ICBYODZDUFUgKng4Nl9jcHUgPSBYODZfQ1BVKGNwdSk7CiAgICAgIHwgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXgouLi90YXJnZXQvaTM4Ni9odmYvaHZmLmM6NDg5OjExOiBl
cnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAnY3B1JwogIDQ4OSB8ICAgICB3
dm1jcyhjcHUtPmFjY2VsLT5mZCwgVk1DU19HVUVTVF9DUjAsIGVudi0+Y3JbMF0pOwogICAg
ICB8ICAgICAgICAgICBeCi4uL3RhcmdldC9pMzg2L2h2Zi9odmYuYzo0OTA6MTE6IGVycm9y
OiB1c2Ugb2YgdW5kZWNsYXJlZCBpZGVudGlmaWVyICdjcHUnCiAgNDkwIHwgICAgIHd2bWNz
KGNwdS0+YWNjZWwtPmZkLCBWTUNTX0dVRVNUX0NSMywgZW52LT5jclszXSk7CiAgICAgIHwg
ICAgICAgICAgIF4KNyBlcnJvcnMgZ2VuZXJhdGVkLgoKU2lnbmVkLW9mZi1ieTogUGllcnJp
Y2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPgotLS0KIHRhcmdldC9p
Mzg2L2h2Zi9odmYuYyB8IDE0ICsrKysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9pMzg2
L2h2Zi9odmYuYyBiL3RhcmdldC9pMzg2L2h2Zi9odmYuYwppbmRleCBjMjQ3NWIxYTNiMi4u
ZjUzMjA5NjcwODcgMTAwNjQ0Ci0tLSBhL3RhcmdldC9pMzg2L2h2Zi9odmYuYworKysgYi90
YXJnZXQvaTM4Ni9odmYvaHZmLmMKQEAgLTQ3MywyMSArNDczLDIxIEBAIHN0YXRpYyB2b2lk
IGh2Zl9jcHVfeDg2X2NwdWlkKENQVVg4NlN0YXRlICplbnYsIHVpbnQzMl90IGluZGV4LCB1
aW50MzJfdCBjb3VudCwKIAogc3RhdGljIHZvaWQgaHZmX2xvYWRfY3JzKENQVVN0YXRlICpj
cykKIHsKLSAgICBYODZDUFUgKng4Nl9jcHUgPSBYODZfQ1BVKGNwdSk7CisgICAgWDg2Q1BV
ICp4ODZfY3B1ID0gWDg2X0NQVShjcyk7CiAgICAgQ1BVWDg2U3RhdGUgKmVudiA9ICZ4ODZf
Y3B1LT5lbnY7CiAKLSAgICBlbnYtPmNyWzBdID0gcnZtY3MoY3B1LT5hY2NlbC0+ZmQsIFZN
Q1NfR1VFU1RfQ1IwKTsKLSAgICBlbnYtPmNyWzNdID0gcnZtY3MoY3B1LT5hY2NlbC0+ZmQs
IFZNQ1NfR1VFU1RfQ1IzKTsKLSAgICBlbnYtPmNyWzJdID0gcnJlZyhjcHUtPmFjY2VsLT5m
ZCwgSFZfWDg2X0NSMik7CisgICAgZW52LT5jclswXSA9IHJ2bWNzKGNzLT5hY2NlbC0+ZmQs
IFZNQ1NfR1VFU1RfQ1IwKTsKKyAgICBlbnYtPmNyWzNdID0gcnZtY3MoY3MtPmFjY2VsLT5m
ZCwgVk1DU19HVUVTVF9DUjMpOworICAgIGVudi0+Y3JbMl0gPSBycmVnKGNzLT5hY2NlbC0+
ZmQsIEhWX1g4Nl9DUjIpOwogfQogCiBzdGF0aWMgdm9pZCBodmZfc2F2ZV9jcnMoQ1BVU3Rh
dGUgKmNzKQogewotICAgIFg4NkNQVSAqeDg2X2NwdSA9IFg4Nl9DUFUoY3B1KTsKKyAgICBY
ODZDUFUgKng4Nl9jcHUgPSBYODZfQ1BVKGNzKTsKICAgICBDUFVYODZTdGF0ZSAqZW52ID0g
Jng4Nl9jcHUtPmVudjsKIAotICAgIHd2bWNzKGNwdS0+YWNjZWwtPmZkLCBWTUNTX0dVRVNU
X0NSMCwgZW52LT5jclswXSk7Ci0gICAgd3ZtY3MoY3B1LT5hY2NlbC0+ZmQsIFZNQ1NfR1VF
U1RfQ1IzLCBlbnYtPmNyWzNdKTsKKyAgICB3dm1jcyhjcy0+YWNjZWwtPmZkLCBWTUNTX0dV
RVNUX0NSMCwgZW52LT5jclswXSk7CisgICAgd3ZtY3MoY3MtPmFjY2VsLT5mZCwgVk1DU19H
VUVTVF9DUjMsIGVudi0+Y3JbM10pOwogICAgIHdyZWcoY3MtPmFjY2VsLT5mZCwgSFZfWDg2
X0NSMiwgZW52LT5jclsyXSk7CiB9CiAKLS0gCjIuNDcuMwoK

--------------wnS9Zj1VrjWIsUrEPuMGuoEI--

