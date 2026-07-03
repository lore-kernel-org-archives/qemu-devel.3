Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 951B7C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 17:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfhjR-00035J-Ed; Fri, 03 Jul 2026 13:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wfhj2-00032D-8d
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 13:30:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wfhiw-0002L4-30
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 13:30:51 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GInSo348229
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 17:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EkllaWRLBZ7cUTvqn2ecRpjA5e1YB5avymoE2ZdtZaM=; b=AFRiIpkBmOxb9VgG
 oikY9MADE7I+Nu57Osfy1+JjmHwhxEN28LAhyKcnCW7u6NJexrsmZrrBvHCukmy5
 00hHe/Kb38ZmYKaNxj/V76N0f4y4uH0soGrbRd0LfpEQPhqTHhhJSLewVRZpCkbd
 0EClwfZDN47JavPKbrxgoEe6w808zeIqcgG8IIHTz6xxum6Ho7vr4csUC7+kFAY5
 lzpuXYYnXokp6+jAdcHniYUgHdJcAkodK3m93qq8sTpn1nr2Fo/8lmmEwC6iDNB1
 wG+cbXM0I1WV9hc3XTjPumd2L29aAanwYPAeG4q+/mO3XqchkW5E574BAIvKQ5r8
 nWit/g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n3db4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 17:30:41 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c8895156101so1224510a12.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 10:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783099841; x=1783704641; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EkllaWRLBZ7cUTvqn2ecRpjA5e1YB5avymoE2ZdtZaM=;
 b=fKF8Q5dWE1rEz9w2rYRZHtaEdlMI1hbro58metZotapvhGlYQmb8jQv1E4tJY+nvHK
 waKwUs7XhCagB+lZL/9KmO80sJAojMRODEJKSznJFrA5la5+aCmi3A3oiHm+rqPxRuMM
 JFLlXk6PbruXnsJnDFE9EskcIloThzif9zfPS6evUvIsiAVZ7xhILjmUk+CKBLkIRb4w
 alLMccq8CFLfGAo3Zsy443QWq0vju1mhFZycxYPFM/YX2dCmYWT7QCx3pmbj9SJv929u
 rWYE6AxPUBZ0zA33+wENB9FUlvvu33smnlZ9P3ci/i+Al9K5LvDoWyFfzPglfX48MRB2
 zfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783099841; x=1783704641;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EkllaWRLBZ7cUTvqn2ecRpjA5e1YB5avymoE2ZdtZaM=;
 b=XXc5p4cMUxTYLzNQGAIzahrRqbS5VHBQcMlMQhJOCR39iujSI/FEjxoDQ0FxM6VwmE
 f6nvHJcaabA2yY+UXJQjfPy6QVX3PfWteU6auTIuANv0oe72BNYP9s/NIayD/eOkRAp2
 PdMsSOQWXrpPW4PjFdCXVWUor16OVVcGEONTAF1JhnqHxEjUfQ/yZtQ4/4GjnlrbWjor
 UhmRC6dxy46KGT+F7OssnToNMcFSu4CbnFFOZHcxGN1Gpscmefa3yeVExKYLTiNbq41u
 hX+K96o6TDxkZDnrulKLOPSPdVJZ0OY25YtlblceEtT0d+9xRAc3I3uNB8DGETDbNzeg
 78hg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UCcibMcHKnrpIsd7JhL2qyDW6KD6U617eBIBSd9TqBUAjP5Qvjt9lrN5S2BnLD3llWR+JpFyfgMC7@nongnu.org
X-Gm-Message-State: AOJu0YzdmE2BscL2xlXRHHN02jJ2PVonI9fNfmArfiux3p3cUaZ1V76B
 7ksrFGuMWTQckWyZitM0lZktFaP1AvNatKhAdUo341O8LFsU3KUuTRdPT1kLHNtmpAg4v78Ha9P
 CVAHumwAHlKpvpuelRTsFqe32bsVsoTmo8r2RG0V9Yps2O9Tpuj+WMqU3VA==
X-Gm-Gg: AfdE7clU3aUGWMY7SPHQf7lOJ0sjakUbcnjXJN79jtvBZfaLz/D69fBaYZIAG5a17J+
 6rNza/orUvckYFOSsHbKULJbMVRzfhW70WWEWkT5KfU6du8MTEa/Lnk11IxqXBgbCkaovoJC5uQ
 wfOC96tWb/7t2ChMtoxWSECDAsfxPUn594BS4EXCzg3nHy3qPtRXvGROqG+g/fCMrhklXZwEQfv
 IE1q7TR6/vJ6sP4fw/vC4QP770qWgO9oahZ6oD/hyOffnXTtToMPahBO1n9PurZMC2sznCrpNp2
 1ErESbQw+BYxRYjer19BJ9LwCGFOi16H5vPK/rsmgkQpLes/2aRUN9e+XmkQ6drc6QNMkvXjf/a
 7xl35hM8Ad94Z0MqIwPY9jm4eUqduWpW3t3KrO1ArlBqY8D+Gk1jkxreXuyjShuSceoG/vwEWSF
 7GwTU=
X-Received: by 2002:a05:6300:2211:b0:3bf:6c08:fb8c with SMTP id
 adf61e73a8af0-3c03e521435mr287423637.60.1783099840905; 
 Fri, 03 Jul 2026 10:30:40 -0700 (PDT)
X-Received: by 2002:a05:6300:2211:b0:3bf:6c08:fb8c with SMTP id
 adf61e73a8af0-3c03e521435mr287390637.60.1783099840331; 
 Fri, 03 Jul 2026 10:30:40 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bbd221bsm23440606eec.22.2026.07.03.10.30.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 10:30:39 -0700 (PDT)
Message-ID: <daba61c5-c7ff-407a-8824-14561ce6ae92@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 10:30:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] docs/about/emulation: document the dlcall plugin
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260701155705.1737328-1-functioner@sjtu.edu.cn>
 <20260701155705.1737328-3-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260701155705.1737328-3-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE3NCBTYWx0ZWRfX3a1cTCbesDhu
 QktTrBKm82dspATCVyxVHZfD0QiS8mpxwRLWyXIJb3vMtWqtLhlNbx53rXSDuxp2YHYB8hEOFfV
 W549+9G9ue0x1KgQVYgtrXqVMVGZnck=
X-Proofpoint-ORIG-GUID: Hrs-C0dK0vuWFkhfKM8YO9NoR6Ouecwj
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a47f1c2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=-BvbgPQM6-dkyUbdcxMA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: Hrs-C0dK0vuWFkhfKM8YO9NoR6Ouecwj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE3NCBTYWx0ZWRfX+gAkBzi0uox1
 zbzxEIb99nuTTXWPqbQc9p4BamIJoY0tbrG0WbLNyi3B6fG93LXUTmkSQxHEfm49SezienkltYE
 CAiOpB7RkTSkTD0RamsnXvYfER0Iwef0mXsj4UUkMyTQYiq8vwxifThHy3y9dTgNjmZZHu+u4aG
 48quRKIp+cwXT1zMSTxAaeCY3J45jcSnwPyoRix+MPbhmN57Gwr556+WV9yBz54F2R0+QPCtVIV
 k7YTFdhDh09MAirzwt1EwmJ/5jeDI9LcBORDt6t2BJVGlEX+3rAp5aSI/0enD3H3xXBFmSsI7Em
 81qfKhiNoxOn3wLErDhXisO0FD06o7G4BPXoRwV7NYdcfm/zY20gIArS9QdrngJGgwETpM60Rdj
 q2SISgYCm1Xw6rTLZOm6+uEJce/N2au2N2Yf4FlGsACQVRk5rEqL6qIzDEKCSTZRXvkjo7hgKIt
 VUddtaKQyCqL7oAUCWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030174
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 7/1/2026 8:57 AM, Ziyang Zhang wrote:
> Document the dlcall plugin under Example Plugins: what it does, the trusted-
> guests and guest_base == 0 constraints, how to load it, and a pointer to
> Lorelei, a complete userspace implementation, for prebuilt thunks and a
> runnable example.
> 
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> ---
>  docs/about/emulation.rst | 55 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index 3b4c365933..8877708d18 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -1046,6 +1046,61 @@ Count traps
>  This plugin counts the number of interrupts (asynchronous events), exceptions
>  (synchronous events) and host calls (e.g. semihosting) per cpu.
>  
> +Dlcall
> +......
> +
> +``contrib/plugins/dlcall.c``
> +
> +This plugin lets a linux-user guest call functions in the host's native shared
> +libraries instead of emulating them, turning slow instruction-by-instruction
> +emulation of a library into a native host call. For example, the stock zlib
> +``minizip`` utility compresses several times faster, because the actual
> +``deflate`` runs on the host's native libz while ``minizip`` itself stays
> +emulated.
> +

From what I understand, dlcall is just a function call interception
mechanism. It happens that it's used for accelerating execution by
leveraging native libraries, but we could also leverage the same
interface to implement something like ftrace.

Thus, the introduction should focus on that.

> +The guest issues a reserved "magic" system call (4096 by default, configurable
> +with ``syscall_num=N``) whose first argument selects a pass-through operation:
> +dlopen/dlclose a host library, dlsym a symbol, and invoke a resolved host
> +function. The plugin performs the operation on the host and consumes the
> +syscall, so the real kernel never sees it.
> +
> +.. warning::
> +
> +   Trusted guests only. The guest can load arbitrary host libraries and run
> +   arbitrary code in the QEMU host process. The plugin is not a sandbox and
> +   provides no isolation. It also requires ``guest_base == 0`` (qemu-user's
> +   default), as guest pointers are dereferenced as host addresses with no
> +   translation.
> +
> +The plugin is deliberately minimal and knows nothing about any particular
> +library or its calling convention. Turning a real library into working thunks,
> +including argument marshalling, callbacks and variadic functions, is done
> +entirely in userspace, and any toolchain can implement the interface.
> +`Lorelei <https://github.com/rover2024/lorelei>`_ is a complete, MIT-licensed
> +implementation: it provides the guest and host runtimes and a Thunk Library
> +Compiler that generates the thunks from a library's headers, with prebuilt
> +thunks (zlib, lzma, ...) for x86_64, aarch64 and riscv64 hosts.
> +

An example of usage for this plugin is Lorelei, which can accelerate
execution by leveraging native libraries for function calls, similar to
box64. (+ example you mention in introduction).

> +Loading the plugin is all that is required from QEMU's side:
> +
> +.. code-block:: shell
> +
> +   qemu-x86_64 -plugin contrib/plugins/libdlcall.so <guest-program> ...
> +
> +See `Lorelei <https://github.com/rover2024/lorelei>`_ for prebuilt thunk trees,
> +the runtime environment they expect, and a full runnable example (for instance,
> +running an unmodified ``minizip`` over the host's native libz).
> +
> +.. list-table:: Dlcall plugin arguments
> +  :widths: 20 80
> +  :header-rows: 1
> +
> +  * - Option
> +    - Description
> +  * - syscall_num=N
> +    - The magic syscall number the guest issues (default 4096). Must be high
> +      enough not to clash with a real syscall.
> +
>  Other emulation features
>  ------------------------
>  

Regards,
Pierrick

