Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3471C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAj7C-0006sg-U7; Sun, 27 Sep 2026 03:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAj6q-0006jC-7k
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:15:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAj6o-0002Y6-MH
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:15:39 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxmou245652
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:15:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WUiGurPna4QzVW1z8ZiNzWcCK/RyfVRlA+CoHMZcGe8=; b=pIeufA1NJmhMPk24
 ETmaDjJPPTX56hrYBL0Qj9Tk+kwCWxtjgMD2Rbj178NZZcpkiak7wUid0NoGxu6R
 dZJtXEzLS8pcMRX7TJyMn3J3I5J4yJQNtc6bIIz91zTel7kLOfU+dnayRC/aRNig
 gsmvrmgrOXRx/QbEPC4yIoMcFkoM62BwFr6Tjb5xm4bhDKrZvD16gasastBmnHJ4
 s7Vi4B8q0tFX9ldw6PcsHdqWY+HTBQ2NWB9LRR3yI/kOcj1L7PZyMTggaS8O+ymw
 gRqdc1ohJa8xzslfwXAF9HdY1mcBzBqH70MjgWzIma+7FJkE/Lafvu4iFdmn8qb5
 EHxAtQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx3dp2tm8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:15:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93bfb2da664so631360885a.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 00:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790493336; x=1791098136; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WUiGurPna4QzVW1z8ZiNzWcCK/RyfVRlA+CoHMZcGe8=;
 b=d8tACSj+gjRAT+kwZCtUOChED+sxwUf5gvd6QUQwxpiJhBty8V2uta616MgtmJ1Xa7
 hU0oefLH86YcjMVsYv6ju8Zd6HfDiMTpl3dZ9ZTyp5XGniSLFiN5fGXtNUCVLnyjJthS
 q1fPfjROtHfDEO5P5sCkgRMRxrGJLB0GWeCP/YK8kRSO5Xfn6c1pKnmVFqIqik2+O/Es
 RXdRMZj2FyGmnhxDgSPZ6yTAbzLu6l5f2rDSrRvVkexijwed5/ObT0vovDebYquHPw/Z
 EpjHK/qoA94N9e1oWmuloirti++aOCiTfe941uXbxb9DLgqR6QujGDgDpMxcNIBqKr4f
 v3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790493336; x=1791098136;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WUiGurPna4QzVW1z8ZiNzWcCK/RyfVRlA+CoHMZcGe8=;
 b=G49DVpTXpgWseTZIp1aaR9u4TtWkGBI8lparXhzhV+2prMAOC1O8V8FYutHcOU1Gxp
 d0wrarpsIJwLbZK6iwz3WjK9Q/00/8n90EgCqWV9p4S0Tggkb6soj1pzjoXjV+XrZ694
 9QgutxGmlUeQ6LwmXEtK6ZKXN2JTHEFOJGCfU+ntO9ljuDaJer45ifRz4VgpDF5RWyVr
 bL/yVPaPcwmRMVAz1MnY5SQwOigUuYUsnOy4jETL56JuVP1uRbajAiyBk0XVfcT1EbfP
 TARKzI4qCE5+3paikkyYhy3GIhNQaP+TpBfh3oBSGg8nJNMZDCFn6Z0eIs4s20LN8i9r
 T0yw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxreYwkuXaxf3oqGqY6zL71+RCZKlKbZPPsJQIkPttEIGVqXFBENIRUI3clGP7CU59jt8eRumfZ2dzd@nongnu.org
X-Gm-Message-State: AFuF++nEcwey21mu08UOUopZfGnqq1kmUmrxWbMbHl9P7/DVyStoyr5z
 O5kX6UxPmuxlqgFrCHp00/Kxb/hym/hq2D/TSbtAzlYSgH6YAC/EdFVo1vDEPp5l8Kl1fRYAxsE
 X6mzXzaaBvGHDg4jepWAUmew+4iiVh0K1KDsyN7Kd1Q6MYyOYywCByccy6Q==
X-Gm-Gg: AYBFou2iJcR2YxDJ1eD5jlzX04FqlteHcSXXwx5WrYnw0E6TBYoH5ehCvZIEuKNI3Rh
 XI/oQUStbVS4M/YouUiBJzpoSExHvWqRcEafkq6+3bwQar2YPzC7Fzg4uApwdVWtDZs+7pzIUga
 lvomeSP9ZMoUsAzaxsBYcGgvGpuwN/W9gajaRzqdrBhM5SKctn2fTU7OtO36BY32Y3PEkRbS8A4
 A0dfqk0v7joFgohCtaeLMlEoQH+XoTOHI56R7F1BG9wpn1R4Ep+19WLsHSQq/65a++ImppXB9Wp
 7h0UafZIVjyPyYUcNHu8LB4jVcCLFMeQyHP3ZokbHuBnIqusij+SFUl1/mU04A9Olir/G+6f76v
 bpWdX82LivgsdudIFt0xjhmtyzQbLhj0QoA==
X-Received: by 2002:a05:620a:46a4:b0:93c:6b90:1d18 with SMTP id
 af79cd13be357-93c6b902283mr292468285a.62.1790493336470; 
 Sun, 27 Sep 2026 00:15:36 -0700 (PDT)
X-Received: by 2002:a05:620a:46a4:b0:93c:6b90:1d18 with SMTP id
 af79cd13be357-93c6b902283mr292465085a.62.1790493336058; 
 Sun, 27 Sep 2026 00:15:36 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a35fb05sm20517954f8f.20.2026.09.27.00.15.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 00:15:35 -0700 (PDT)
Message-ID: <46355b7d-34f6-4f0d-be5d-e656e31aff75@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 09:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mac_dbdma: ensure only implemented DBDMA registers are
 accessed
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20260914125236.820155-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260914125236.820155-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAyOCBTYWx0ZWRfX0oFb4Hb/BmdH
 tdsYNB7eL06mG+f1KjCelWxqWEYY2dYoZ4RqmAsvJBnD09H4vjFifc04AzGrc08NtHdgCR5DDf0
 ZC8RhWngVSxT7AwHGE62kNbQixgylGSC8Bc4khyO3+qFnMubHoaxv8y3ok9aXTFLRwWN3dDIqH0
 CQi/MEiEZVWeNRnDLB/Tv2vEf99tSBdmtWAL3kBItAbh7Xe73mTc43OPulHdmduZjUsq67JTeOw
 4BTPdRyVYOy4NRnzr4Zfvz+am2xdEakXzUtio+8wq3Sg7y/g3BxU9lkKHcyuS+r4S3VLM9f3nFd
 0Fs9BTkHjulVGmK4mwkJMMT+ImL5Y++PY8Kpgynmy5CNgJ1t7X4Rc+6zFXnjxLbpmO2n1gBXWfU
 fmpQ4GNl6AV/l6kxtZVnokx3vef+1ARH8VsuV/4TxVPN1h4ULcmNq4RYDdzEJ71LMr3BV4PxlJS
 CeAZ3pjMocw+6MZjViw==
X-Authority-Analysis: v=2.4 cv=QsXLTlyd c=1 sm=1 tr=0 ts=6ab8c299 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pcZqCyVeAAAA:8 a=736gKsQ0j4UtIq-i_HQA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=SGy6VSG0Ue1xmPAwIFl9:22
X-Proofpoint-GUID: D_Wlskp8D3h0HCZGvdEkzmQ4zEUUXWCL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAyOCBTYWx0ZWRfX47XPNjw9khT6
 EOneU5IPBk9jwOapLXnCxoblu6vnCACT9wheSb1v25X3kktDjB8maFON8A0di8VR04XAK04KoO5
 cRjDX2OgPV8+pIlGQlq28Axe6MWmb6I=
X-Proofpoint-ORIG-GUID: D_Wlskp8D3h0HCZGvdEkzmQ4zEUUXWCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270028
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 14/9/26 14:52, Mark Cave-Ayland wrote:
> Whilst the DBDMA memory region is 4K in size, only the bottom 16 registers are
> implemented in the Power Macintosh DBDMA controller. If an attempt is made to
> access any unimplemented registers then an out-of-bounds array access occurs.
> 
> Rework the switch() statements in dbdma_read() and dbdma_write() to handle each
> individual register access, as well as providing a safe default for all other
> unimplemented registers.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/misc/macio/mac_dbdma.c | 34 ++++++++++++++++++----------------
>   1 file changed, 18 insertions(+), 16 deletions(-)

Patch queued, thanks.

