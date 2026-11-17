Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8508606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ZPht4LNh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOfk-0002tN-5C; Tue, 17 Nov 2026 14:16:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOfh-0002sv-3A
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:16:49 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOff-0002gN-Gs
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:16:48 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2e99b1e5b4cso1082685ad.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794943006; x=1795547806; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6ZeyCKhq7JPvbgBQH0/SUKEDp2jIM9Om2BoTYYPfaSc=;
 b=ZPht4LNhx4T7jhi2AJ696rvn32XkAs2PKTL9jCIv6vjXGpW5g4TkWPboqnAISsJlHF
 3N7AHFT4uZz+UE6CM+q0HuiEctPvVz4QC1tcs4orq4ausw4PbtYnt7FBY2+GwTq3YqtF
 VNMihxcTEzaeE5jnDqkGyd0f4VjzCagTG4QmMnSJuigt6pY257lWBfqr4JjjaneB/oYy
 Cpf7wVfWZHs+Zz3TFCj3beLVoTJWMajEjFA8IsoTv6rs7WWU+EGFFv81mjVHMdt8SR32
 NrQx/NGsUfwjFZKiLF6q89i9gVRMF4W1N6f8YuIBQHGmodrgyu8lnCfuCTPKomLwzg1s
 lQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794943006; x=1795547806;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6ZeyCKhq7JPvbgBQH0/SUKEDp2jIM9Om2BoTYYPfaSc=;
 b=oaddj7mSvcwHeu7y2CwVS7Z0ZFdnZ7laAO91Yu4uBeaVO5oj1GQXU5rZDcxqz6I7g+
 wdtasWZ8N4abwfgH8ASq3EblM3bPtUbzeLGtpC1iw5NY75E3gpfEhlJeh2G8URozaDmA
 1UlD1gexT2oDxgD8GOjGXUWOwzF3/1RIomMZdfhjTH/cMgGQJusWYvNJwDT4qyS6ShKv
 ZfcqrIUlS7LoTQVUwlCzGOGgQlMkjIhY6HzMS+huVcPFm3rilOf4tiyRpFMASK8jjVOx
 k7reauKsljnVI9hcY1J8dAm5yhpBvFrOThr41e9NT1mu/iVPBSHidarRCCLz4s7IQrW/
 wfHA==
X-Forwarded-Encrypted: i=1;
 AL+hErGakwA1NZQwtWki0H+FRQXFarxnSdGV0atqcpWVX6J6u2SNvMelEKH1+kCG0QMT0ZRTyhlfLxXh6TrG@nongnu.org
X-Gm-Message-State: APuU4Z9HAm7rEoSaEVEQqccYHERMVAbtZQKllva5vafuKE+AViC66GtW
 wlBDV0tcvksO50kkxTRtSbmn2wHYJ65QWf33gv3jGg9HmpMoXuJoqtmeea24FYDPdTY=
X-Gm-Gg: AZFdTZesLfv7u/DR0z0qcVqskcNJbbUyBSKoSlKsQta7j0FtHGdtuH2Wg5hXjGpiWOa
 MOWJAtkz3a0t6igO8yEdLko0VHfcUMLbnQUTSE9Tt7hz8xs6zVikauMH4ALe79H72XWAl3AGqY3
 GPil3+cR/oJTIqT2gzO/PMJnDpwJwn8UdKBfgQpIFcxtqx9Q+1YtoyVqYNcjqp/z1S5BrTVFRZa
 Z0neJo/l+JopyAt5MLTZp9qsrTqqqj0rVF8fSqYd/+ZlYhgJbJ12+KUa8W6dynmlvHtQYEMTn8g
 /Bh2mU1tKh9rSqGav9WkyAAzVw6gsCfEEebZ4DfXPL7xTEnGU/TNNIUOUzoXrRewl1Zofp+UXhJ
 bKEdGO6rH1uSFxtdPxg89I+z5RQg5dfT3jyReu3QKq8r1Q35XO1XioOW/ksgJB/JiLTkpcbRE1z
 AF6Odrq74cwnQLvTfnkyYvVwtSpOhskQh5KpehUn2K9jK19I64OGF6+DvhVaeYagCaa2wmh+G/F
 15B6lVK0QKGQYaTiQPW1mH1jtWNiufBj4YXJJaturyY5+m76N2WBsBG3TWn9bSPpAIp8W611JGV
 URMalcucwMscG6rwjiI9uaQ0vlgegDyAyygDfqg/EL4ccPEwtAjiyAci9ikAn+2tiL7krNo=
X-Received: by 2002:a17:902:f650:b0:2ed:2afa:9221 with SMTP id
 d9443c01a7336-2eff73f8fdfmr2454485ad.27.1794943005562; 
 Tue, 17 Nov 2026 11:16:45 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eff61162d0sm1802365ad.20.2026.11.17.11.16.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:16:45 -0800 (PST)
Message-ID: <78d98322-7cfd-4597-bd0b-cb98c95001e8@linaro.org>
Date: Tue, 17 Nov 2026 11:16:43 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] target/mips: Fix nanoMIPS BC1EQZC/BC1NEZC always
 raising RI
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-13-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-13-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
> The P.BR3A decoder passes OPC_BC1EQZ / OPC_BC1NEZ (the MIPS CP1
> opcodes) to gen_compute_branch_cp1_nm(), but the function switches
> on the nanoMIPS pool values NM_BC1EQZC (0) and NM_BC1NEZC (1). No
> call could match, so both instructions raised Reserved Instruction.
> 
> The P.BR3A encoding is in MD01247 rev 01.01, printed page 288.
> Switch on the values the callers pass.
> 
> Fixes: 11d0fc10b7ef ("target/mips: Add emulation of nanoMIPS 32-bit branch")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/nanomips_translate.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

