Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EAFD29C33
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:41:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqRS-0004jM-GQ; Mon, 19 Jan 2026 09:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhqRN-0004gv-AE
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:41:14 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhqRL-0006er-R7
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 09:41:13 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so21173805e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 06:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768833670; x=1769438470; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kgz6lXUVhNQzBU8nYQXX32pEYbExce5M/cYH5zH7mww=;
 b=wGEwX/qL/4bRlovCQ1ue0SBRZ/Bnh0jCmU49EpSeE3giO60lpQ2BLmP1PKyQGO/lVA
 mwUnjQ56dzN1DdHN637hXWY40lQAogIT/b9WjZhK89MztrgjZwHirmJhl8DeyQKqtcPY
 RBOfjr+7TTbJPrrTGmB7+5De3vJ4ORCUwQ8+htBBfGcq9u2ibJl7DciczZi72xj0GCPs
 jCYrfCmIq7h2EuLMhIpX7TqATPO9ioMPuvbvgfnovGeoKAKE0gpPinZ+HhcxO3U5RXko
 dzXE5uuBRZH/Oat+LwVSfsq+h+bCul35qFZxZbjVjMivynKC+LJkyfu1Pnc6BtWvGvgo
 VWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768833670; x=1769438470;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kgz6lXUVhNQzBU8nYQXX32pEYbExce5M/cYH5zH7mww=;
 b=JWbsV46Vnyvr8Z8g6sFfXWWo6r57C4EFP1EZzN7g0ScFT9qwpgSu5EAITmrBD8h9j9
 j6GrcMWSiQUXwlCaiD5ZLBeXiEA31VwWANFMIApXMXt6M++N+F6fEMDjYWWw6AWL9hSe
 87Ufy4aiYm94c2QlIjckZqh9WXRL7UPPS1eAdJBC1Co4pV2eN2AbcKllZ57Lp0vPp6uD
 ig5iMOLz0Yg7O4mjanIi0TRn/5oAylcLw/Hz5reImVorfsArzSnwylMumVJmLIRzAsU9
 /kuF2GZfSHrglHaTfNBd5HPlLrY6wQG+uZzj+yZJiXRYk0o5/NTGVShCEsEMNphVpGX0
 KCEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU01QXIJIRlnTP29llYaMYOakRPPzEH7WPgITrdRaPNfL3+cRLMZcTOGX65PcU8OPYMKZUYcnSq8IoE@nongnu.org
X-Gm-Message-State: AOJu0YwOODPfffszzS2l1/gvq2o6qY4kIuJieWDpEzkjq0gvtDFZxHmF
 QsC3muvVSbNkUT/Q0XCZqQ97ksH3VfIyN3J+MNAc6ZJz+jhYL+SubY2OpK0SezeQy6E=
X-Gm-Gg: AY/fxX7blcIEShnYF8eJuHGsEignr2+H/Fi+ysYG2XTsYfxUceJDLjcf3Bo0rYICmEd
 RusB2kaF5TSBLHWKt9K+IdfmpzgqjQcfca5CNbVT2NayHxjCMNR/usbyCl/Tsr9gKhbtN/U5vqi
 JBKjE31M5ZPe6pDAB4smgh/8ndr56RmqS20aC2OF7xEt1q50VY3h+1kEI6zq3P6+JBRDDg+9yxz
 EMUxPRzZgSN6XjTW6F/R0aDmHNUbR3yz/0jDfstbndxRKv35/X+6WsvuYFd1gm0HiA2DEkP39l+
 NsIZdulogGBlzwIHcc/LaLPdGI7Z/V1rUdrBME7rtsB+25HGCmlRubT5Lrp5MIt2CEZgaACAxMK
 qvNO6WLi/T5E3pmOOMymNNsY+nDXDkI3vxJXIxK1unBzytRyVJK4/MvAUE/vYsGMCbGr5d3u105
 9WAAzWQ/yH32lKwm4OZq6cpxow243MTyT1UivagVl9hHDGMsoDYTtJ7g==
X-Received: by 2002:a05:600c:608c:b0:45d:dc85:c009 with SMTP id
 5b1f17b1804b1-4802a5e6b3cmr84498945e9.10.1768833670134; 
 Mon, 19 Jan 2026 06:41:10 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997eb2asm23666376f8f.37.2026.01.19.06.41.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 06:41:09 -0800 (PST)
Message-ID: <c5529834-516d-4b14-bb5c-eec352594dec@linaro.org>
Date: Mon, 19 Jan 2026 15:41:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] configure: add ppc target back to container tests
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org
References: <018a86fd-b831-4fd6-b479-9d73e2e95ee0@fhofhammer.de>
 <711cdf08-7275-4c3f-be6e-ced88f874207@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <711cdf08-7275-4c3f-be6e-ced88f874207@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 19/1/26 15:29, Thomas Huth wrote:
> On 19/01/2026 11.25, Florian Hofhammer wrote:
>> Commit 2ff8c9a298 removed support for 32-bit PPC hosts from the build
>> system. Unfortunately, the patch also removed the 32-bit PPC target for
>> containerized tests, which leads to an error when trying to run tests,
>> e.g., with "make check-tcg":
>> "make[1]: *** No rule to make target 'docker-image-debian-ppc-cross',
>> needed by 'build-tcg-tests-ppc-linux-user'.  Stop."

Oops.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>>
>> This patch adds the PPC target back for containerized tests.
>>
>> Fixes: 2ff8c9a2984bb20e350ae52152812c5370b02e32
>> Signed-off-by: Florian Hofhammer <florian.hofhammer@fhofhammer.de>
>> ---
>>   configure | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/configure b/configure
>> index e69b3e474e..1b0af0cf46 100755
>> --- a/configure
>> +++ b/configure
>> @@ -1451,7 +1451,7 @@ probe_target_compiler() {
>>           container_image=debian-all-test-cross
>>           container_cross_prefix=mips64-linux-gnuabi64-
>>           ;;
>> -      ppc64|ppc64le)
>> +      ppc|ppc64|ppc64le)
>>           container_image=debian-all-test-cross
>>           container_cross_prefix=powerpc${target_arch#ppc}-linux-gnu-
>>           ;;
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 


