Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B85CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbwcY-0003B2-1K; Tue, 23 Jun 2026 04:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwcV-0003Aj-QF
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:36:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wbwcU-0003Zq-EE
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:36:35 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65N6cfFO2992374
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tep1NWzNKJcJYpuDzBs1W69J+oDdOFE1XeS0ny8Tg9U=; b=Ui56LQcCDX/3WCV7
 m0GIp87hAxvg+d23bVUVkkm9QPQASrLFzA1UlB3ub9JUAzKAuK0LcYZe0hY/xszC
 JYp4nHgNCclUvldMLUy2SXl1098gsUby7YHfaAeVtu46Kqy0WDmyhf5982F4Fwij
 FATisPKho6sgvsf8oxo+FEwi8RBxYk3d/4gvJhT/imcvSA8J060oEF/Hp2mgDE/y
 mRiJi/HcwTEmU3RuVg9rQ1+Q0B3srI2rXeBJm6+ciDIiwbI9MbjtZg3L2yD7hyh/
 R37bKghuyzKa4+WjUVcozSYwLYIZF+8GFvslCR2nvg8RYOOdBHAj+UZzhQTEFPR8
 B661Fg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey729uej1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:36:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9205e6b0bcaso681196485a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 01:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782203791; x=1782808591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tep1NWzNKJcJYpuDzBs1W69J+oDdOFE1XeS0ny8Tg9U=;
 b=QNZoSnMD1iR7QKHKE9Avv3D9mVhcZzeeysBTNHeLVO8GVBW5JPP6kDU3wJ0+BC0Hqp
 iuCsn/HDLXW7fj8bHM8R/EdiTgmt9Bpaq9SqTzYaT7SYAZQ6D0kQOvmoYxAp5SrgVFar
 hCzqmj/LSPhw1ogeW4NwELEHja6GVrK+DpvRZammJcTZXO/fdRyW1ZRzQbrYQbjmBF6S
 DTY/Rk2zabje+h24FcokgGmPWHsQR80hd6d0E8iHb9BL4PiuFFugu6rcjHuFyP0cxuJs
 wnnosE1OGhL+bb9jfO1ha1q8biGKfSAF4gpx/GAKgCG/X/tQw66hSlI93Z1usAa4s57H
 IS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782203791; x=1782808591;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tep1NWzNKJcJYpuDzBs1W69J+oDdOFE1XeS0ny8Tg9U=;
 b=gnI0BspiaGcTTLuFq4rwQXxsOb4fFYijeOJ5gENK2riFDo9w6bwvWoJpYYChAAMWZH
 k+sMWlEXh/pFXeU01QCWuygE3utFzP1ku2Dv12sTxKkgZrZ5NHX2gpU1jFlkrKz6NUyk
 1u1kTQYsVLYhurwVuX4maanyrKKizvtRv7sSXvbQEqYTKGVG9AmsOUTlTTCMBJxbzA5d
 +Sy/bkSR8Z2lMWFVsukupMda84U/2lgRCS2jb4nzmIFDUxzNBBlsgkYli3zdTJVgFHON
 r+5+vhGjo3gaQFt1OPCZQ0D/o/kd7tsVMSJuEwyokDHerESKlws86iSbpXwDTEzjJ9gV
 +mSA==
X-Gm-Message-State: AOJu0Yw8fp8Z+2VU7HV/1ehadwr6BtnBOJl7AtRjZ0dy9UyUeXQwXgHD
 g8txydPUMX/ncPf4faoW+efMPWnzcTluYHsJvyzndS/A2DB1rXVeNRoAAYwjCJd9+VjQmEPz5SI
 MAxUyKcMDcv+AA+2MjeUUZ8SaDYhYy4R/Mf76wK3W/C5MXYaeOQIp1rhFfg==
X-Gm-Gg: AfdE7cmKZiLpWcVqnn6T1HJZ9pLrNtrc2u1GDY9K1V0ohB4CUywao/XgUudInr+mshW
 jU+WEFu9glL3m3KqgMaNYIDNsYOzN7P1+zgYLm+8DA8rD6J7ZkzzmCYabTkrbfkmd1++astnp+P
 uCEn+uVQucb7gA7I6+q5KEm3xZ+NKsWN/08NA8iluDbRjgRiVWZVFpejyruME2j24kksocofQ6w
 cjs5nGcT2XJYIEGozdwJY91uWrAxmhr/Jon5lliRKjznP6vfOtxUxgGTDEThV1L1knn7xSL4i5D
 MqcHRD98acRFddHXs693pioTXccXKoSenyK+OTyRYbj36cV2NB1rh7iASbmb/YdE6Bj7Xi/EJUQ
 WzSeDfmG0cq3PcHs3JYFDEiwte0gOZ6LU5BYIkpjera2mjQZwniICFZDXnwuX2A==
X-Received: by 2002:a05:620a:394b:b0:914:e3dd:17ea with SMTP id
 af79cd13be357-9266687769bmr295770585a.12.1782203791327; 
 Tue, 23 Jun 2026 01:36:31 -0700 (PDT)
X-Received: by 2002:a05:620a:394b:b0:914:e3dd:17ea with SMTP id
 af79cd13be357-9266687769bmr295767685a.12.1782203790857; 
 Tue, 23 Jun 2026 01:36:30 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0c610e4c76sm476030366b.46.2026.06.23.01.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 01:36:30 -0700 (PDT)
Message-ID: <3ee29a5b-4f6f-4ead-8f7e-1c060cff83aa@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 10:36:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] fifo32: add fifo32_peek()
Content-Language: en-US
To: Matt Jacobson <mhjacobson@me.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260617235032.21491-1-mhjacobson@me.com>
 <20260617235032.21491-3-mhjacobson@me.com>
 <b11f77bf-68e7-47f8-9c39-612edcf45467@oss.qualcomm.com>
 <5B21F4CE-023A-40B9-B3AD-F7B2A03C4054@me.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <5B21F4CE-023A-40B9-B3AD-F7B2A03C4054@me.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA2OCBTYWx0ZWRfX6FKoJAj1Ouwf
 eacZxu6BYpBlFeXn7yDuaocsYS65OXg3GIrUxJlf63VNRWHI4tjmoaREZ2XQF8b79U0WQXtc8Fl
 vRcfNIhXXw6ICapdyhmBQ5C8rxePm+g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA2OCBTYWx0ZWRfX2WITS0tzDpcu
 /uqdVTZdpxR33r6QC5D5/OvATkC45vn1iVIk3Tgm/OpauHm/sQmzpG74RYiTCYHZ0SSEe//gBKe
 BXXDXw4oYhEP0HG2vX4zUrfiPDKLwcPljh/STt5747HAflxfIoaHxV6wYHUAv38qbKeECX9riLG
 6yHUbTSfqFANw4/dQRps2DOmo8hqnKn883VJZ/y1JeSJFeKPCtkfAlET0P74DGbkMt/6oreCSal
 jRnfABnsrrcDcqnSmasG+pyxnsqx5WThJAIy9oyXo2f6w2U1MetAOaRKUKunMIGRK524yXHtQjF
 CQ824sbGRFMrq9k0DYX/xxCm8uQ64jdAsXcrH64Olz9zNdWiYSnu+8NybloVcTX0qMLuNseIq4D
 HMDZLvMPaPOdv2ae9zVqEvUQ43Q+vVM90KZyAKcsjW7XaJUOFtCNevrnf7Qmndr4uHXsAYMCKoh
 vE6HE3ZSUtKse0jSgNQ==
X-Proofpoint-ORIG-GUID: 3AIu4kMUTgBGwPifzAYKwug3FGwjAZ-h
X-Proofpoint-GUID: 3AIu4kMUTgBGwPifzAYKwug3FGwjAZ-h
X-Authority-Analysis: v=2.4 cv=eN0jSnp1 c=1 sm=1 tr=0 ts=6a3a4590 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Kw31neuGt6IESYGms1kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230068
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 22/6/26 18:12, Matt Jacobson wrote:
> Hi Philippe,
> 
> Thanks for reviewing.
> 
>> On Jun 22, 2026, at 3:57 AM, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
>>
>> On 18/6/26 01:50, Matt Jacobson wrote:
>>
>>> +static inline uint32_t fifo32_peek(Fifo32 *fifo)
>>> +{
>>> +    uint8_t bytes[sizeof(uint32_t)];
>>> +    uint32_t ret = 0;
>>> +    int i;
>>> +
>>> +    fifo8_peek_buf(&fifo->fifo, bytes, sizeof bytes);
>>
>> Could this work?
>>
>>        fifo8_peek_buf(&fifo->fifo, (uint8_t *)&ret, sizeof(ret));
> 
> I don't think it would, at least not without other matching changes.  The existing fifo32_push() and fifo32_pop() routines explicitly store/load the bytes in little-endian order, so a single fifo8_peek_buf would not work on big-endian hosts.

I briefly wondered about endianness then forgot. What about:

           return le32_to_cpu(ret);

> 
> The rest of your comments are well-taken; I'll include them in v3.
> 
> Thanks again,
> 
> Matt


