Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE1FE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF6H-0001BH-Ao; Fri, 13 Dec 2024 18:29:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF6F-0001B1-PM
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:29:35 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF6E-0001ml-5G
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:29:35 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361f796586so27036495e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132572; x=1734737372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Gb4goDicfQxicR5u8nKj+41W/sHVMjmHq/TZvClCsfo=;
 b=MwZcX/lqt9lv043CgO/1Jh9BLLoiGoFYh1QvfmtLdjN3JwHYELSX60tMSOURQRto/I
 QxspP+FQhiJPQ5FDWFSYg6cX7B1CqFpbluOz3AuzWrG3tkDdx49U361byU1PU+G9k38q
 mdvd7vUens7dsFFkXmM4gdck/14Eb1S+QfJbvyu/q8HwAtQQm1xLBYFSSXCIrqFi5K1f
 j55q236pD8brbqpSWqoFsIyQdp/pXECRXjDU7+wxA+SpRk9ISJb2lSMxczR04PuayQz3
 UWcqP5z7KkNROrkdagTdgq99v1KoGpa7pl4+efLTJ9mkBKQNBjWAqknK2GPdmhPdMYiH
 EuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132572; x=1734737372;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gb4goDicfQxicR5u8nKj+41W/sHVMjmHq/TZvClCsfo=;
 b=sMpVOtEl/Rsra+DY5+OT8zJk1OAx7WFIFgc8biBlp+0K+LUhlISJQj0PEQ/x1EnxC4
 zp+LJT6eLT9Q0KtBlSksmv5teAs++WLNJillFDqWLfYn9ZW/jd5evj0NtHIy3SJNHWNO
 /lP4UAmXAZYD2I+pk2v83HhVx1/RtogTdnNROv1nTcwfeRZr35IGUnVIvFKlMY+n6WXf
 zaTBzi+xaZBs/jOJ8CLxIbCaXXI3zJ6ndcel+tT1r79+6fN099pLqD3C+HGAwPEPpfPx
 oTY3+/ZEW9CHIGHlgr7rStHeWPSC599ctrTRwVx8bZKVDXrgGpAmQW9nv39c4LX2VFt0
 5vxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJd/JdT2rm1u6FKf/BVkRwpijXZPwUPXW0EWf+FcEiDBOhJpA1AgifwoZzzP4rhB7viuic79dyE2qW@nongnu.org
X-Gm-Message-State: AOJu0Yws3IpILyY8aP1cMKFKhyHfAGOBEj1tm62svmt7XfwSmq1Q8Sml
 83dHWfGVc/A6FahXNKyjN9Xq01C0CS+K94dUWecdgsZnPoeDSfAz6FmQtk5X510=
X-Gm-Gg: ASbGncv9h6kraXFsc9xoqvKR1f28lAPtsrcjT0KOA9m9xRJk2s1agXX3q9k1JGihDSU
 5hGBdK5akbCRBwy0uQmxIaejD8rK+vWjjctNM1SZ5ZxK1d7mIJM99Y7E28xayu7+cwlwLLWOlp2
 JkuUpToz4AYoM6BB3MaIxXx9HOCO94W/Ho+G75KzXkx8dscmTjzTBmMK5sccq7tNCvJvUuNMir5
 HIJ3od938+G8S48k93EtrNixb+S/JkdOaRP/WM8JiPwekLuF7rXU/z/arELwR+rqlxXxA==
X-Google-Smtp-Source: AGHT+IG3t1WpRAsY1ABuCMl1UNesWjInxEL0qLdAAn67u7zl+WULAng6uQCWP9RnQot+hWIAt+UYhQ==
X-Received: by 2002:a5d:5f50:0:b0:382:3959:f429 with SMTP id
 ffacd0b85a97d-38880ac5f31mr4213526f8f.5.1734132572340; 
 Fri, 13 Dec 2024 15:29:32 -0800 (PST)
Received: from [10.1.1.253] ([45.93.146.194]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801a487sm845169f8f.45.2024.12.13.15.29.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 15:29:31 -0800 (PST)
Message-ID: <cbb49707-dfd5-47df-b268-e468130e7cb8@linaro.org>
Date: Sat, 14 Dec 2024 00:29:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: correct my email address
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 quic_mathbern@quicinc.com, stefanha@redhat.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com, alex.bennee@linaro.org,
 quic_mburton@quicinc.com
References: <20241209181242.1434231-1-brian.cain@oss.qualcomm.com>
 <7af8a419-745e-4348-a564-8ef078fd456b@linaro.org>
Content-Language: en-US
In-Reply-To: <7af8a419-745e-4348-a564-8ef078fd456b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 13/12/24 20:16, Philippe Mathieu-Daudé wrote:
> On 9/12/24 19:12, Brian Cain wrote:
>> Mea culpa, I don't know how I got this wrong in 2dfe93699c.  Still
>> getting used to the new address, I suppose.  Somehow I got it right in 
>> the
>> mailmap, though.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   MAINTAINERS | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Queued, thanks!

Dropped, already taken by Peter.

