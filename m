Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A967FD47CC3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 10:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggql-0002rJ-NE; Fri, 16 Jan 2026 05:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vggqj-0002pY-Ss
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:14:37 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vggqi-00048Z-BP
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:14:37 -0500
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so6459465e9.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 02:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768558475; x=1769163275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lhOhejElDWYsa+FJkwTQcIT/3XORz3CjuaOqZ1LNEcQ=;
 b=N9s2a9LE33S4dkOWUPJw4AW3QMMjjF9qyh8Fn5tBEo8v4ewjbwEgTgAQPGiJ2rAGhR
 DULuEcT7D5VBEOZF0b2cxovVGmePeg97L/sDVpsC6z2I5/Hzbbx7O8dKCzwU/XZrw7wg
 +XaVrFtMKvAiFEG4yB3k6ecOXO0mLTPMEq3clD/Fm8j48DJl3dnKmA3h8RSWdJKSO1aX
 wxWojwvvRtgKPm0FPhSV19+JJ43Erh38Af+vh5bhiV41TxmSXNdM8sZJKRgxX7fahcex
 TdLBCw6Iz1LCpg+/88JRryYHi8XKfYMoyOFRf/calQ6Vpy8a5uLU59jmDK4YXKYlrOG5
 mNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768558475; x=1769163275;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lhOhejElDWYsa+FJkwTQcIT/3XORz3CjuaOqZ1LNEcQ=;
 b=jhWELW2eII9ueuqsqTkm5m6NRs++hZQqFEtTyW4/xInL5R6Gae7pJlMVc2INhLiOnr
 uoVLJilo+kQOvHD2sf6Yp6EQ8yVq9CrZOimXQkEWN1g/M/h3AgzCBIfRssaA0EhXMLLM
 eT6UFVlikiTyGLNWQfB89S4rJOU16CL03JoqPkr4qJnbXznBeCz0YEccI1US04C7PYbr
 FY2P/0xq2KJs8p4tUa4W/sQwBzfXjRlsjEPw0lk23lGVfRNgwNhjIndqJrDCHYf7VJmu
 DW9ObZs78ak9RL9k9D+0dD9jStzpW0boI2LpBGsTYWTGhWGfdAhHCO1ldRMQN0xfPZ6f
 Nq1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdzC73y5lSRqZK2c0k35Vxr/hvjNymgybtpfn8SZonWkZfN7EvyTrUx7DRs/8AGi4TQcU1NT5FQo7V@nongnu.org
X-Gm-Message-State: AOJu0Yzqvro/wgnfZ7FFHlaV4w54cfP0cyatHKjHDngVBDLnjhCrcyJm
 x/x4CE1fyLB/ctal1WCflKH0oC+1fqEwfpQgEtfP/vz1lhMrlC6C/Jap/+DD8axC6hQ=
X-Gm-Gg: AY/fxX6bTDlhrUG7QH2vlu7Pv5KnStzwxqBMFXXU+jgkDLo4oAbwXDFsA6f2H6QT7+d
 CZos94RMC9r7H2ZAGNMMdtymvfViiYg2F/SjpxKUrSIPj0htMdSG+LptbrTiKwpTkrtNWZvUv/2
 GIcYlTb3lhKo+3tp8HD+qgrfeZjQPjF8BkfpAEsJNvfJJLWdlDLPXPl/CQ5gyooI6YqiriCrgZX
 Jkwlo0tZJ4kRlLLGdp2oeY96lGqA8s8i4qVVO1VSETb8ofomFBTmFzPZJNOOWL3b939xroBRgqf
 btHz5QLoXSAfQqH/fYok4BFU8a2FJ/jlPdCHYtfE+HmX4rmNdbfMMpZvdmSSCCTOQprxjEkPmqu
 c7z9EPzvAflpQKd28qRvScRfG1e/xkkJa9SPbRLAXFAemNiUJIgtDMdQmCXQ6m5DaVZ81y9BYEn
 1zTM8/YJkM+xJBheAalpIKlh1hryMd7bwtIkC25G6ZLhh2x0cWpev1hA==
X-Received: by 2002:a05:600c:3b8e:b0:47e:de23:dd6f with SMTP id
 5b1f17b1804b1-4801eac0a1dmr22789435e9.12.1768558474618; 
 Fri, 16 Jan 2026 02:14:34 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4289b789sm91559305e9.1.2026.01.16.02.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 02:14:31 -0800 (PST)
Message-ID: <73d3023e-a872-452f-868b-8a646da9d4f3@linaro.org>
Date: Fri, 16 Jan 2026 11:14:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/10] target/arm: hvf: pass through CNTHCTL_EL2 and
 MDCCINT_EL1
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20260115045042.70086-1-mohamed@unpredictable.fr>
 <20260115045042.70086-6-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260115045042.70086-6-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x341.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

On 15/1/26 05:50, Mohamed Mediouni wrote:
> HVF traps accesses to CNTHCTL_EL2. For nested guests, HVF traps accesses to MDCCINT_EL1.
> Pass through those accesses to the Hypervisor.framework library.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index fe9b63bc76..fdfc8497b1 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -297,6 +297,10 @@ void hvf_arm_init_debug(void)
>   #define SYSREG_DBGWVR15_EL1   SYSREG(2, 0, 0, 15, 6)
>   #define SYSREG_DBGWCR15_EL1   SYSREG(2, 0, 0, 15, 7)
>   
> +/* EL2 registers */
> +#define SYSREG_CNTHCTL_EL2    SYSREG(3, 4, 14, 1, 0)
> +#define SYSREG_MDCCINT_EL1    SYSREG(2, 0, 0, 2, 0)
> +
>   #define WFX_IS_WFE (1 << 0)
>   
>   #define TMR_CTL_ENABLE  (1 << 0)
> @@ -1289,6 +1293,12 @@ static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
>       case SYSREG_OSDLR_EL1:
>           /* Dummy register */
>           return 0;
> +    case SYSREG_CNTHCTL_EL2:
> +        assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, HV_SYS_REG_CNTHCTL_EL2, val));
> +        return 0;
I'm getting:

../target/arm/hvf/hvf.c:1264:59: error: 'HV_SYS_REG_CNTHCTL_EL2' is only 
available on macOS 15.0 or newer [-Werror,-Wunguarded-availability-new]
  1264 |         assert_hvf_ok(hv_vcpu_get_sys_reg(cpu->accel->fd, 
HV_SYS_REG_CNTHCTL_EL2, val));
       | 
^~~~~~~~~~~~~~~~~~~~~~
/Applications/Xcode_16.1.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/Hypervisor.framework/Headers/hv_vcpu_types.h:312:5: 
note: 'HV_SYS_REG_CNTHCTL_EL2' has been marked as being introduced in 
macOS 15.0 here, but the deployment target is macOS 14.0.0
   312 |     HV_SYS_REG_CNTHCTL_EL2 API_AVAILABLE(macos(15.0)) 
API_UNAVAILABLE(ios, tvos) = 0xe708,
       |     ^


