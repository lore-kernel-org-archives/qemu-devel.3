Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F52C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 15:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1pgG-0000bJ-JG; Tue, 30 Apr 2024 11:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1pgE-0000Y6-HR
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:46:06 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1pg8-00082y-Qz
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:46:04 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1e40042c13eso40066985ad.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 08:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714491933; x=1715096733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J46ekdL8imsb2JbocACOPoQXETvGO02eg7sh7wxnxGc=;
 b=v+l8CbyVTMBRWREVFyRspl1op/THbfiESkUw9tbDY47039C/ECyfF0AZlt/Wb4ieaj
 EdFlCFO0R1ranV+nLkMFcf8aafy8q6eryJS2m0c4xx7J/a2HSOu/Xql5jKrbpBJxbrKX
 RFyJ26e6tdst9A0VM+ibvi0QmprWry3oGpfk+qlXB2AXtxRNjOVXyts6su/hlkIsnEHb
 1oGh5PbYAyNoDzZU9quJywMAETHGoPMDTYVu7wYwnhqvdi3tFcIepM1H9/B0GCUSTrE3
 +NN+h60iQ8FttiO+UhA4ooYlsqw4dij1nwSViczc06d3BUg5b11ge7LkNzeQU4gfYVGV
 AmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714491933; x=1715096733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J46ekdL8imsb2JbocACOPoQXETvGO02eg7sh7wxnxGc=;
 b=AUHZduCOiqx2jbfN2420ihzDyi4agalSsAnvhEdgEBk/U5Id7djx7G0FGyyEfP3Wdm
 1xFFXgCwcKa+t3VHeowQ5c6Aa9/90imdbXtZT5brRCJP5P+f/72beTdx0Tn2rgsHJECP
 YG0/ssfoRRg4oh9LY1yhYf7cJLBC3FmpFCXntGHZTn7HcOLnbQs0P7P4HAZj2f1jhmoQ
 Dp44vClOleHEomFuveYNH7eZ5kiF1p6qSb0AKBJWcn7lOlTyz4cweVYPbLSSAXrMosjm
 MF9QhD3UjBJ5CfcDJQ82oq1W7N0jzZYn/KBlIB+ln+am3O05OxVLTpkFvQ4TIkNoL0XT
 TC1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGZQHmp+fBFpRn2lP38Ex5YCEKcy+t56LZ57A0aNiKM73NHx9FyuEZhAbHxn5QBnbGT8++PY9s5FHEmzomISj6o7Vq8jI=
X-Gm-Message-State: AOJu0YwWCwlBxo6zAS0XztS+f/BpJUyuZQNsiKGg65gA6H9Buzlz+ddX
 DXj3O9b8waX7A9V1lOESMlcJj1Y28ZDzqRXFOKzDeh8IF/f0aj6gstosYmf55rQ=
X-Google-Smtp-Source: AGHT+IF98WbLGJp0GA+uO2jyo1n+STMjCwUREDw/w4IfV1hqtBXCH3raiH3wZzPKTqattJaai50ybg==
X-Received: by 2002:a17:902:ec84:b0:1e4:32b9:c39d with SMTP id
 x4-20020a170902ec8400b001e432b9c39dmr16618272plg.13.1714491932649; 
 Tue, 30 Apr 2024 08:45:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a170902c1c100b001eab26889a7sm10237388plc.136.2024.04.30.08.45.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 08:45:32 -0700 (PDT)
Message-ID: <a7252766-7beb-4206-9041-5638c09e2460@linaro.org>
Date: Tue, 30 Apr 2024 08:45:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Hexagon: add PC alignment check and exception
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 qemu-devel@nongnu.org
Cc: bcain@quicinc.com, sidneym@quicinc.com, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com, Laurent Vivier <laurent@vivier.eu>
References: <5c90567ec28723865e144f386b36f5b676b7a5d3.1714486874.git.quic_mathbern@quicinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <5c90567ec28723865e144f386b36f5b676b7a5d3.1714486874.git.quic_mathbern@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 4/30/24 07:25, Matheus Tavares Bernardino wrote:
> The Hexagon Programmer's Reference Manual says that the exception 0x1e
> should be raised upon an unaligned program counter. Let's implement that
> and also add some tests.
> 
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
> v2: https://lore.kernel.org/qemu-devel/e559b521d1920f804df10244c8c07564431aeba5.1714419461.git.quic_mathbern@quicinc.com/
> 
> Thanks for the comments, Richard and Taylor!
> 
> Changed in v3:
> - Removed now unnecessary pkt_raises_exception addition.
> - Added HEX_EXCP_PC_NOT_ALIGNED handling at
>    linux-user/hexagon/cpu_loop.c.
> - Merged all tests into a C file that uses signal handler to check
>    that the exception was raised.


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

