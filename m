Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A191C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 08:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNTFA-0007yx-LC; Sat, 29 Jun 2024 04:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sNTF7-0007xx-PS
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:15:33 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sNTF5-0000IY-RK
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 04:15:33 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-366df217347so854256f8f.0
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 01:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719648929; x=1720253729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2K7JhQjsaNZhN470Um0SV8XjhThpsUnASuwgXVhzg3E=;
 b=cL+L6YthK+RvNDRicu9RC0M0cxv3p031IxTXRz8SATqohGgoPIzObGxSU2iArCAbaf
 vj07OpV1y65oEac8oSzCc1CW21E0PISsnlMQVbWJ3/rrRGkSr5IiSXy9iIQFLB6umvmh
 ZnLzxERy/My7Wfs9CzdXv2ZD4JFLas+UTuwnHu40Fh0NzhOZnIIDzzoDoiEFLFK3bE9o
 YoWVr2q0oXtxD1GdBSaQYV4TxNP5QKxA+yC02n0BVCe0nKsZaS7MQj42Vcc2se9BWm/O
 vCKMtVXtCbBnnccMB6jwqKXcqZTndAC3QKxJE2M/V8j2VzcUO4FvsxiYo2t8JQKnCKz+
 8ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719648929; x=1720253729;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2K7JhQjsaNZhN470Um0SV8XjhThpsUnASuwgXVhzg3E=;
 b=oEe2QFgdJcbp/hQwgQagc+Dvu92yx+pZv1YzptJURcXoVEqXbckthEscVhwOtT3kNw
 iFoFVMkYWdghJfQ2Y2XoB0k5FAXZerfSF4GJ1cOrsuh03/EAvBDeG/5Ze9PKtlbkeXDH
 hjV+fUvszbN0pYGsLys+luF+bfrdOrzZXWVjJbQoyDAL9TvvCxcjQzVzIEi8vCqZCC2o
 PpF06hZxQo/cu8h4bVd5EMeIYsY3U0lokJTgJNX+IvcMiSCNO6x2F04s/ieOPqP8xjdQ
 jkHH3hEnIDfOxq84hccRm9qUppMHM78ti6XJMQLoDi2IP+XGhUvwCcB+ejORyT9oxAEF
 K53g==
X-Gm-Message-State: AOJu0YzngwvDbNaAc/2yl1UORVrzkNcUfl5Tkd2vrO/+3pDkS10ygjM3
 lKoGz6m7aTjY8WnWDac6RNg/RY0FFPLpPcElqe6dHQ32FA4mSMaRI0QRF58rsYY=
X-Google-Smtp-Source: AGHT+IGpJ53QwhT1NUR9N1g0UhsJq82r2SAvoLh+TlX34MGAV9D7QScOOmDFXwqLINx2+GgYP5Gn4A==
X-Received: by 2002:adf:f98c:0:b0:360:7092:728 with SMTP id
 ffacd0b85a97d-3677571c8d0mr363525f8f.55.1719648928862; 
 Sat, 29 Jun 2024 01:15:28 -0700 (PDT)
Received: from meli-email.org (adsl-193.37.6.1.tellas.gr. [37.6.1.193])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a104023sm4209985f8f.109.2024.06.29.01.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Jun 2024 01:15:28 -0700 (PDT)
Date: Sat, 29 Jun 2024 11:06:46 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 Alex Benn =?UTF-8?B?w6kg?=e <alex.bennee@linaro.org>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Marc-Andr =?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Philippe Mathieu-Daud =?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v3 2/5] rust: add bindgen step as a meson dependency
User-Agent: meli 0.8.6
References: <rust-pl011-rfc-v3.git.manos.pitsidianakis@linaro.org>
 <6bf311a35e6d3bfa8b3bfd10d8f896a9e655fa30.1718827153.git.manos.pitsidianakis@linaro.org>
 <ZnlGlOGORQkOsoO5@intel.com> <fl60u.ry7sk6d8fv39@linaro.org>
 <ZnrpgW+CopiJAGZF@intel.com> <fnew7.3urdmuxnhe3l@linaro.org>
 <27f52dce-b659-446d-8358-50b6001f7307@linaro.org>
 <dfa7bc8f-378f-4876-b630-fe1182dca937@linaro.org>
In-Reply-To: <dfa7bc8f-378f-4876-b630-fe1182dca937@linaro.org>
Message-ID: <fu1lr.ewime9aej60m@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x436.google.com
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

On Fri, 28 Jun 2024 22:12, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>I've been able to build rust device on windows, with a few tweaks 
>needed.
>
>- specificy the target for libclang (used by bindgen), which targets 
>MSVC by default (so different set of headers)
>- additional headers (libclang searches its own header with a relative 
>path instead of absolute)
>- additional windows libs that must be linked in final executable
>
>However, even tough I can build the executable, I get this error:
>$ ./build/qemu-system-aarch64 -M virt
>C:\w\qemu\build\qemu-system-aarch64.exe: unknown type 'x-pl011-rust'
>
>Any idea of what could be missing here?

Sounds like either the rust lib is not linked to the final binary (which 
you can confirm if you look at the included symbols and don't see 
anything with rust origin) or the constructor decorated with     
#[cfg_attr(target_os = "windows", link_section = ".CRT$XCU"] is not 
linked properly (you can add a puts() and see if it's invoked or add a 
breakpoint in gdb)

