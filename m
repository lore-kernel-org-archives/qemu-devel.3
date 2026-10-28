Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C668E606A33C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wCGddhfe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM5kg-0003zV-QF; Wed, 28 Oct 2026 11:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM5kf-0003yy-4z
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 11:39:45 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM5kd-0002Pl-HM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 11:39:44 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6fbf1ba31fbso549076eaf.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 08:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793201982; x=1793806782; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mHjnrJEuLd12KCYgxp0nF8GBsbP/mQ0Xsqdpe9jiF6c=;
 b=wCGddhfeqzBhFVU7QlaDmJs9xO2cOB/lh1EjEswEyqMITequnxYVvZmiVbzRtjoTg2
 l0LRJwPhfhpfkifhDg9tzEzhPrU9wB78AtENGHCUwpedoWoi9r4/mryLo4jmdIjaFYcA
 M1CigsoS62vRmpwL6ECZBw7vuBQvu66DUbAkQXpeLggFCxgVe1VcWi9WbFz2xzR7xuHf
 xw8uw5veVFSztawpWfYlGCmCCIvy9qK3V9ULl89L4W0mjNryasrnVTvum870iX47nhvH
 bZdZwaXtOgqsGNJo29PTDL6KCnjtSDdReBa8IMewj/O+XdAkcoVbxLwAVjYDmD9K9wbo
 j3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793201982; x=1793806782;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mHjnrJEuLd12KCYgxp0nF8GBsbP/mQ0Xsqdpe9jiF6c=;
 b=0TjryDqiJgt4iHUJPmJhsYsp09ziMTVZGvwxLk5gV/xkdLBqexqvF5/eRkzf3xddx+
 hbaNhgYvxbggq0RngBxTHySjfqL5jd+5jUWyoTm/Upck0U3iVXu3F/9UZ/W/Em3iq6TM
 jZi+Qyz7vr5S4rGvkrnC/d2xfc5fysWVlKC2AxaRWcRP3UEB0f8KjMHwQDFW/kYeOj+k
 q63Mq5Wq4+o4Vgr9mK4J9b22LPiC2d9VVtbeoR57WfRSEv4NMdxfhz2PdUriwudmthFL
 noA9qECs1Zgy1WuQIyNtVa5Ifqlutp/OzF1EN2TJJKbElcuPz6Sg1wWAGUBXkalVRhAN
 bG3A==
X-Forwarded-Encrypted: i=1;
 AKwUvByG65C3brxA0JDIfx4nuJkIO7tdAep2dgFYMQRkqUN2v43XzfB99SxsnCEBjs5oZMo8v9KaCyHTYira@nongnu.org
X-Gm-Message-State: AFq9FYKRHHLjwOjkfJYjq9OiIqJKvScuNMWNy8kwSprXQfwE44vjEIao
 dHvTgB2VqJF8+r/1FOQ7DqmcaC+ti92K5KI3/65GhBO+BksOUMGDhltyqHeLt55eYW8=
X-Gm-Gg: AYBFou2eMeq5A0Lhk7mmtPu7fTx4HCwAdpwmgk0SRj+AyatE6hgubGE2TaCp3cUHVRW
 6vWUcrqoptfidGc1xF8VocShGbVNXvOTCPdGLkcadlWg+wiBUByXDNeeM9LI0JGKD5x+gfKx3JQ
 16q1uMVu9CjV7Mgxp5aUdQnxOUfwAn9ABhKZnr00myu5JjMDA+ygLCHigKJrqbdoJzifGVMXhnr
 /5u6bQAASkeKz+gNy0R1gCc1/bjNRZL5nN1U+vjOZ3r2+XudZ32j5Qp/Ubny2EuZXe9RxTdOoXi
 ee5czItKcGxwC50SU4Wb2+tS9sAS7/kVJee9hlbjPbajmeIu5Mc1Ln+WEY/JY+L3W1z9b/HFzE2
 bZxG3l5EyweOG1/UpxJl2HsEgZUTjQIigGomybACFrhvV2qGQwDCw4VEyhpom7RNx1H72vLqciP
 mL6li0TRY92ANZzw3VXNKmanudfOFtN8Re1iTAQjNCb1X0Ood4LIbOHUX6mm/ATHxo+W5WCKcEc
 CsUQCW+DE0aIYvAiu6O97CnQ4DzzQ9uikTBSIRQObgir3jN+mW1YjNoT6lAnoBE43nxLFL00of1
 OedlJq82wbb4Y2nifqJl+6GAeI4cucGpRKJnmeHqSERBVAlhsNwOfp6NgKTFDYyt9BQnMhpJqLL
 S46slvH0fVX5K
X-Received: by 2002:a05:6820:a502:10b0:70d:1692:14ec with SMTP id
 006d021491bc7-713ef91f654mr1043247eaf.52.1793201981732; 
 Wed, 28 Oct 2026 08:39:41 -0700 (PDT)
Received: from ?IPV6:2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6?
 ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-71429d864c9sm1684900eaf.2.2026.10.28.08.39.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 08:39:41 -0700 (PDT)
Message-ID: <c22165ae-b25b-48f8-9e66-bc4cc22e4dfc@linaro.org>
Date: Wed, 28 Oct 2026 10:39:37 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/86] hw/intc/arm_gicv5: Regularize spacing in
 config_readl() switch
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
 <20261013083933.1024405-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261013083933.1024405-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/13/26 03:38, Peter Maydell wrote:
> In this file we don't put blank lines between cases in switches,
> except that for the switch in config_readl() we've written it half
> with blank lines and half without.  Delete the blank lines to make it
> consistent with itself and the rest of the file.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   hw/intc/arm_gicv5.c | 15 ---------------
>   1 file changed, 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

