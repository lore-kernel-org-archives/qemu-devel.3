Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C820606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DiK0w281;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QTZe/gJr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQXS4-0002sa-0Z; Mon, 09 Nov 2026 17:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQXRf-0002qc-HP
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:02:34 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQXRc-0000dI-Mk
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 17:02:30 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9LA4sC1375910
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 22:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TtS8mojH2TV5F+xsgsLreAAM7xAA0qw+BJ+RMhwr55U=; b=DiK0w281OUQa5Ch9
 s0Ii+H8eiWF4J8DQAdFHKrNO+mfWJFtSarTrffVwEjSeEV9dMVctjNiabYVNsJ/s
 8k5e/zmLcXTRvielGMshmIkWf0aJiscyIv7wIokH+yDzJQWG9PsGq8z4SrrXqJxQ
 nx3gfwticcJ7gtMP1Flavfwg+2eyUoAwrNs/4VsBXldbuqmO4idRMdL12hPbe4dl
 v4llPtIk/IBqUrxBvtomsEUFwE/3xeeuoK3lbbBMgjqemXD9Qr6XF7hYEF9T/eKd
 wekc6jDjlm36qYzzZepLWOO2BZ6mdgp4fZNLp9PjMY6pRrrCIHlc996qgzyMaTqL
 nX3m5g==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudf5a7ye-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 22:02:26 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c83124d530so1646077e0c.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 14:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794261746; x=1794866546; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TtS8mojH2TV5F+xsgsLreAAM7xAA0qw+BJ+RMhwr55U=;
 b=QTZe/gJrThbX9lxK4Y1XQFpr2byLT0W1N/i1dchOVaL/vPX79KIn0k4ZF6PB5OpsY+
 Lg5l6WLV5yWCS0vYtiYTi1oSnV4m052GMf8KrDRBYkUjuILGx0VTne4LoJdNrlnAJtEA
 A6vpInaOP1y6SaOXzJREbWKglsJtnBDINzMfyMh3pi/4YxatYy+93T681Si4f8GedutR
 H2TgIDaEY3Lc7kf7fs5H4vG5bGItLkq3K4ALwKl3DvPUEhlrwh81RZuG0p4iGwtps6p1
 a+0D1cPcwc72BwKq9hfBnBecV///ecRl7qUhq9J8JPUeuXi97aa9T5jQHsDN2ppkTGWS
 WwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794261746; x=1794866546;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TtS8mojH2TV5F+xsgsLreAAM7xAA0qw+BJ+RMhwr55U=;
 b=HRAJMHMseX64d5eWKg/a48voVhkLXW7VujIlbXRMitPuEInlq6fENPVZymxVR3sj1Z
 RrlKzaUI08ZL0w6o1BXk6jrJ2WYAJd9+9ZMOY440rQV+CG/F9XDYYWuUxiev2ITyDV7u
 QD64wvq+ESD7nQ1K/krHIE5sxFqbuU0vw9kE3KzCllmr4AIjCNLLwmFl0X7qLYGojvvs
 q8/MjkxyK1668gIgeSmuuXTnZnkrfgD0DjkEi6qZ/eFya5ZpLo7qElAQSGPstP/U7o1U
 I4LKBi8k413hAId+rVAa066k3SeQJMXmmaeElqEFmDKUuef/+SGbstrgKEnrTTnlmeIo
 UTBA==
X-Forwarded-Encrypted: i=1;
 AL+hErGBwKBWyN01e0Gr3aD9wdQUWKBn9onnKk/1OZ8SozDmp6iT6jEBa2TuSwnPgFhBYqJNOjarENNQ0xwd@nongnu.org
X-Gm-Message-State: APuU4Z9u6qcQvoP/uwTPwTDSCAd53rnH02VbOYrt+YbJWgEgw2I9OMdf
 ocQOUy/axfahaH6v80CZaHyksXLRYCoJu9GNgxBWLg2pBeuY3keHjgZld642xXH2ieqQXyDQRV0
 wY9Cz5v2GAPQjRA7h3s2OJvkG0XCcjRpaEd0OdZwkcf71WcioA+J5HYP/yA==
X-Gm-Gg: AYBFou19fRl6KQgA8zocvRgpILJM9z8HhscjkwjbDXJzHMy9vUZHbdzOkjLKfsAAROn
 2ajnnZK1f8PU/vBjRGrSt2a3rHLwvhXyvosvFMLrKlL5fgvISrrl6SXu5juF/E9puemyZJM1ypM
 4O8QJY9HrafMzCGYmSaN/bZS/6vhpBnR14GXC3X8Z1pnbUPnv7RCUAW8UyZyPJ4Jn73eV48xZWP
 ylQhPQXKP6TiH4odo3vQ4QmYFyqHCJAuCBewcKiGoLMlQgtC2jR8Kefm6qKb+zjpPRPwdJdBCGP
 yLjp5sJSfq2R6ggWv1He9bUW59SqCas1EKctCoR3v+YGf8Eng9JJghjfN6pw8V3p4DQp0PP+e90
 1IQNJ06bGDHSoFvgI/BjdOxpdogP4sPL6RMwr0t6lCvV5MjbgR9s28bCO8PHZbMDXbAt4CZQyf8
 GABWbNDg==
X-Received: by 2002:a05:6122:420f:b0:5ea:bda1:7689 with SMTP id
 71dfb90a1353d-5ee0d094042mr219301e0c.4.1794261746403; 
 Mon, 09 Nov 2026 14:02:26 -0800 (PST)
X-Received: by 2002:a05:6122:420f:b0:5ea:bda1:7689 with SMTP id
 71dfb90a1353d-5ee0d094042mr219280e0c.4.1794261745917; 
 Mon, 09 Nov 2026 14:02:25 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49835858f26sm1234854f8f.18.2026.11.09.14.02.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 14:02:25 -0800 (PST)
Message-ID: <36e3b062-1bab-4c38-b739-0fb9f8c76162@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 23:02:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/u2f: validate ring buffer indices on migration load
Content-Language: en-US
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
References: <20260916092342.2447-1-guobin@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260916092342.2447-1-guobin@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GakJ9YGmS9TGyAva6s_wPFvybVa5UKWv
X-Proofpoint-GUID: GakJ9YGmS9TGyAva6s_wPFvybVa5UKWv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4NyBTYWx0ZWRfXzeiKEhxAOBMw
 4KMMruCWMt3xTEVPkdPx4ovqQcNL/0+rg/pJqhb3axHVRTl0/gdHll0bqjUEwprVeSXelW9xKPA
 YHhi8LFLYhQaSStbn+1pvWU9D1C2GJQ=
X-Authority-Analysis: v=2.4 cv=bar+w+PB c=1 sm=1 tr=0 ts=6af242f3 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4NyBTYWx0ZWRfXxcoCwSdBUJ1U
 gZAdw9+jN2YuJVa4X3IEoayzHPiv9p4Iex5ZXbg3nH8kHQvFae2NeFZAR02z38NwYbB/n+dT0fO
 SI8PdI2dWXK1G0l/sVoUhf2w55HHdkwu7o4FV17c/BOaKSTQiW13/43YhFpvURkp5GaZU/TrgHz
 kD+Gpfg2PfxzKzM/oNeFKVeoeo2lqRS5wOskxN+daArfi3OJHheDJJkLK68Up4naIdlDpZ/RCi1
 2lzSVyXwkey4iD9E9WldjyQq9nf63neZjVwpam1j58N7etqq2L24owGtx6PvC0pO/SWfKB7eChD
 9pF6AJzDwlDTR97Kqx352ojMq0bvTARSAx7m1fkrfuCfdTWVjjAchyvGJFPoey7s22PVRTJToFv
 3inzrHhUnldcC2jk1vplzZYfecpg/kJUlI6No0SBUV1vylvpyC1veYoZs0SzZizpEnQWdkOjU4O
 +kJMomFQvn56TWvHmqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bin,

On 16/9/26 11:23, Bin Guo wrote:
> The U2F key pending_in ring buffer uses uint8_t start/end/num indices
> over a 32-entry array, all serialized in the vmstate.  A malicious
> migration stream can inject values >= U2FHID_PENDING_IN_NUM (32),
> causing an out-of-bounds heap read in u2f_pending_in_get() on the
> first USB IN token after migration completes.
> 
> Add a post_load callback to validate the restored indices and reset
> the ring buffer to empty on any out-of-range value.  Pending packets
> are non-critical (the device will regenerate them), so resetting the
> ring is preferable to rejecting migration entirely.
> 
> As defense-in-depth, also add a bounds clamp in u2f_pending_in_get()
> so that even if corrupted state somehow reaches the consumer path,
> the index is folded into range before array access.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4483
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
> ---
>   hw/usb/u2f.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
pending_out_start/end/num in U2FEmulatedState have the same issue,
do you mind fixing in another patch?

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>



