Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946AEC982F0
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 18:25:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgoVD-0002Hb-T0; Fri, 16 Jan 2026 13:24:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgoVB-0002H1-VS
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:24:53 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgoVA-0003J1-7M
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:24:53 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-81e98a1f55eso1244165b3a.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 10:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768587890; x=1769192690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3t0fppGGp8wbeBJsZlJjCxZfJnR5T22zy4KMfifvV2g=;
 b=b9oCARZXSwmaVYyBLfhNNyYlJ//JpxhfiZC3Nza9fQTpRK2DCs7uXzpaznAmpFb29V
 toWr5/d1lD35JvPghvHmtlTmzVNYDjhT0v9yESx7y7bFO/ThQ7l4CXyGnV7rhG1/7arV
 X9l1Oty82TfqID++BdpajtQCgPnjnwz3EKE0miB6PFlJYG5kOkzsXJXIP+WzL+URzp45
 huLFdKAccg7GfFKt3OhALMQxO6VzYnA5bLMUdwzUGFrP2r0mXqYg380FQSxb0BOH2J3t
 CAJKzWJ8QBeA2NZ94hOml88JcoAveCwqt8GJDltwgUg0I/VT9OMcQIgHox7co0g53t4Y
 FWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768587890; x=1769192690;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3t0fppGGp8wbeBJsZlJjCxZfJnR5T22zy4KMfifvV2g=;
 b=VwHuQnbB1KFRQyumFxO0iT2PPLeGEiYZAz2//P+RK072uX4FBUPkon9889HJ7Ui1ov
 A4E13l4RkmkPH7ucRGu1k/SEngipcMjijNnzsgUx2gPZypZVYZ/Wb+HIvd2VXUDlE1BF
 9jdPeViKO7hO59j0tHVlvV/6Yl/FVD5bEHL0D5sEL5Tm4U3qFQaJKmYxmyf8LojeZEZ5
 Gzc8lniWsH5QeCXFQB/louz6HX0Gf8A8i66WCve9/02CWyA/uX9p6XPhEhA05Q1d271O
 vAMw/cNN9scWCVXC3PpaG6QvGU3/PpLx9sU00VamVNii3lY7yUZcFS7skbcVfBS3YUPQ
 c4PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU77gyoB4BglqseR2m+bbvoue7s9q6ENaS1y7WHU+suT9/S/y2T/37rniEVLcmN0SvaoMPtOggVqXcl@nongnu.org
X-Gm-Message-State: AOJu0YywatXyJlryOY94ZTpxF5sZri+y5U4GjJXrvboR0JinuQ7FT7bR
 MDcN52b/Fxink0cpplmLsssbEJg2xxRrFujoxH/QC19wjVpr/2BZcpGfqLT94uMdyV4=
X-Gm-Gg: AY/fxX5n35Nq4JuarBl5OXh8xtXmWcLUxUj176kyOQ48ZlG/87JCJhq84DFUQgLtKzR
 nLpPEkSaGTpFOednghMco2Tv42+FHqATMtU/c0KKuG6rUn7ljEP0bQGNGIkCe0YuJf6TkZHSSp2
 2D5HRj64bZXz2JNkDGgPdJLhhujnkuHumRQ9I/rXjZxmFX1mVN4jI8OqVmlFDeSxEEZhpFPQOYH
 vnAIZjHIMqlAY2TtbAIqRffTPN85lVjxd9qsdvPkinCHg0qmdAbvpQvF61APeU89TbIshv0iK6S
 a5n/OjXqPeJ6ogiLpTJgIHRYhyehWIkIeRcAZ2Do7nmVNiH/DC6XZqvgebbHXX1P72U0+hYAB/+
 id+cFpLLOWHhAQIGWuKlG25+oMZ/jnSlJ0Os5OUMKNQnPgLeqFU1ZkEWLetbdL1ZkK18WKeyJSW
 mg+V/UdGl2EE/7/SVyICSxyNJNHlKcRZbXPWoQG1OwrpszjNRqIw6M7cRF
X-Received: by 2002:a05:6a21:3383:b0:38b:de3d:d527 with SMTP id
 adf61e73a8af0-38e00d1aa44mr4012578637.48.1768587889856; 
 Fri, 16 Jan 2026 10:24:49 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12787e6sm2603600b3a.37.2026.01.16.10.24.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 10:24:49 -0800 (PST)
Message-ID: <0d32ba74-9171-425d-ac0e-1303d6ca154a@linaro.org>
Date: Fri, 16 Jan 2026 10:24:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] plugins: correct docstring for write_register API
Content-Language: en-US
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <60089475-3891-4448-bfe0-8dd698cd2435@epfl.ch>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <60089475-3891-4448-bfe0-8dd698cd2435@epfl.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 1/16/26 9:38 AM, Florian Hofhammer wrote:
> The return value in the docstring did not match the return value in the
> code (see plugins/api.c).
> 
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>   include/qemu/qemu-plugin.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 1f25fb2b40..def6693a17 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -1002,7 +1002,7 @@ int qemu_plugin_read_register(struct qemu_plugin_register *handle,
>    * Attempting to write a register with @buf smaller than the register size
>    * will result in a crash or other undesired behavior.
>    *
> - * Returns the number of bytes written. On failure returns 0.
> + * Returns the number of bytes written. On failure returns -1.
>    */
>   QEMU_PLUGIN_API
>   int qemu_plugin_write_register(struct qemu_plugin_register *handle,

In practice, it may return anything else than 0 (see 
arm_cpu_gdb_write_register for instance).
So the right (vague) description should be:
On success returns 0.

Regards,
Pierrick

