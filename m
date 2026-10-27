Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA23B606DA15
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HWUImX3g;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YX57yWf0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjQW-0005rT-BP; Tue, 27 Oct 2026 11:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLjQU-0005qy-98
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:49:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLjQS-0004eK-Ca
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:49:26 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RFL5Eh1061287
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 15:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 swoChnkZqXznzJYBJxut7/GaNtyqYZsnj1N2o9Z69TQ=; b=HWUImX3gA3Xjaj12
 bvjyfrs2N4+N4keuhi9dPrgdn7wi7kceSyaND97tXoucxElyAT1Q29pTE1ChARAE
 865z7qo8oXPIz9U8xiefY9pnuE+YjeSIjYKi2GnZSczx8gyL1+S95FeCIseV7O+p
 tZ/4yFgiU+CTAT/1LEbXPavzFPYD/JrMV3X2evOXjoEXHR5PzpaQ3vE56fERJQtR
 nfcP8DfecZJsRKh7Nal7w+ySOeazCI4mi3i4UCWdD7EqwEVF8kziWaqcpyZB5jnx
 K2VWB2BV50RDv/K06EJ8maoaM39BtIgS//HQ+hFOIjcV1pecIYNT7lmSE328+NrG
 ccS1Ug==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjb54mn6y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 15:49:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caf6c528aso678771285a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 08:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793116157; x=1793720957; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=swoChnkZqXznzJYBJxut7/GaNtyqYZsnj1N2o9Z69TQ=;
 b=YX57yWf0dINBS7DMISZCbeZZcwrqRRRb8hiMALt2iTN24Kk80+a8g4zDLZcKjLSwup
 to+onMrWqMPG5ev7F73481hL8+28dippHV2mNKeonNNJSUhHY5RCzPVKyQrnKDaGkP3Y
 HTHvRllWGOmFOaJ8dMQ9h+OyXvBwHxI9Zvo6XW1EhCBQKcc47q6RiHuq9CFhZL8AFvub
 sJL+fQdQ2zG74fCFClB1U8P4fUN0/gdXlseKoRX4lKOsrSJjig2kXKRN1IYcuRJ2GyH5
 SUu+EKzxP1D2bCySNtJjyD69s/U3UdoaZqH9OwGhHt5NyEM0Iy6f2wHLsCqQKsyRERv9
 0/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793116157; x=1793720957;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=swoChnkZqXznzJYBJxut7/GaNtyqYZsnj1N2o9Z69TQ=;
 b=l/lVrvrOr6YXTsvkzvsreE8nRd/kvHYc+AsMmpu+VLqkzbVjO/e/Zh8HVghHTdPDrf
 ihVjqlHDpOTPK9q6JKfOVK9FLOjHUfBVvdBTTCeGBBOFt8R8xSfJ+sJ8aYgR/1YHm0PW
 gP9bK/Fe9E8lcLq5ilRQDAGCvVw3I5DzgFlpYsTVU/Kv9nacpq9nk2SspzZZlFRBwMq+
 pdYcvI0oPxvpUmS4edfhj1S+Y8buH8I4emFoaDs5xH2BBLC3yabyb03hQh1yajcFVPmE
 15Y7k1D4p05eJHAiHWR7hOcXth59nKjsBylGFDT2RR2H/lxKqbe8vo38tO6k9KZfrv55
 MXVQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0h6DivjoUnhOEiXxLANlqhid+YuO/DAVZLiQ05YxFNpc1lyflXarMgOu+a2Q8lIF5TgIDs3CMklJ8@nongnu.org
X-Gm-Message-State: AFq9FYKlQiR9EdDlR6+0ne822Z+IHEyHZh95zXZgZbUYkCIcilJ8kDyB
 RlF187Ltv+u5EHu9ylP6792y62quL10a0tWdWEGctNE3YYvWxXgRqkXPmfWuIXmc0PTGkkegvlq
 +VPbdVoifMtFJU8nJpZ+dKDUZ1y5YPnRGXMyDVm7asXXIiaLsRro7csf0KA==
X-Gm-Gg: AYBFou2yxSZFTRh6km/GwWXz4oEhkUpXnM9aUeuxPaVNru4h2mf5eLNX03NA9gphE1O
 sJLUjyb/xlQ+LyYUMucqu0LqOXWv95+VLRJEQBrFZsuP07vLPRVzxjjGJp4ttpGai5j90ZqenNb
 GkQk+6RJQP1UDdpsHhlYrPDNKuut4SqRSuwTtP6vbk185mmKy1aRyNTuZsX1j8un1mw9Q2r0xbk
 iwYDZdyPvzGzgqp1Tjp/YgpXwIFglfL5tRk4q6XzCfXeeuonC13+Onoyn2WU0niI4yxs8YcuGUY
 Rgop0uElu917DZqaVWe56jMxW5wqstIdp/IWeaIjPAWVkuDQIqVEL+ArvZqR7X47mJ/bSYko9A1
 CvWuo1671Lk7g/uZ9bh4NezDjWCdjYnsgh2BAR4Mcr9wRqS9v3Q==
X-Received: by 2002:a05:620a:458e:b0:93e:6283:eba6 with SMTP id
 af79cd13be357-940ef955e85mr1716014785a.38.1793116157455; 
 Tue, 27 Oct 2026 08:49:17 -0700 (PDT)
X-Received: by 2002:a05:620a:458e:b0:93e:6283:eba6 with SMTP id
 af79cd13be357-940ef955e85mr1716011085a.38.1793116156983; 
 Tue, 27 Oct 2026 08:49:16 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fbd830sm137832025e9.1.2026.10.27.08.49.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 08:49:16 -0700 (PDT)
Message-ID: <cf956195-778d-463d-9c0a-2a828181db59@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 16:49:15 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/25] hw/mips: add Octeon III EBB7304 support
Content-Language: en-US
To: "Kirill A. Korinsky" <kirill@korins.ky>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org
References: <20261027104433.25720-1-kirill@korins.ky>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261027104433.25720-1-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2MiBTYWx0ZWRfX3+BN0egsHxVv
 HXYg2QlIZiMPPhluiKyAxn2j8C7WnAYGrekO+w5wrvM6FdZAZOsjnhDBvXRV1cXdoDE0mheTeT5
 yVYwuilU8sYSLYb5bI4bGX1Fo9lFUNk=
X-Authority-Analysis: v=2.4 cv=bsnZl0ai c=1 sm=1 tr=0 ts=6ae0c7ff cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=ID6ng7r3AAAA:8 a=alGDw2F-mSSMp1XgeDQA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-ORIG-GUID: 5Aih0Qbh4YFtH87dhGPQoQfS5NqE944t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MiBTYWx0ZWRfXzbQGrTmuwzLU
 +9KRNWg0Sfu6/6gQqYf59S9K29R/8plVrWkudPLDz6kHbup/cV/uUbvZjsTyVh15jJAvobp4kcP
 XPZ/UVbf9gjbUSMSf5Ho/44e1ilAR/rdk9OC//3EFnLtoAKJ2HeMLzdncbaolpLsUsEpUtnRAoN
 W60ux44LSuJLDyUzR+VD9bVspXQs227FEpQnSEdcV8qx+ya1sIJUUM/bR9K8Om0O0tClAsgwhH4
 xKoUlDPwR3dqlJoI428qAjsSWng8/rtQa8TxM41T5VoIs47IeYQK5fQvr1rmpG5Go2fBxvWzLvj
 LGyGz2zQ5Am7HfaYfSWPf1m5oi8GshYHmHeJL9ke498B055AMghKu4TZBYquYfOSmNd4lZB7xsO
 CPFmE1tapzHrL+5+VUJGq+UW84pDFsszChSg3Na04VkzHzOCFQQLzrhdMZkp3/SEiheEYuL39/9
 qsjnmV8ThrueYfjVHpA==
X-Proofpoint-GUID: 5Aih0Qbh4YFtH87dhGPQoQfS5NqE944t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270062
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Kirill,

On 27/10/26 11:41, Kirill A. Korinsky wrote:

>    1. target/mips: make CP0 interrupt state atomic
>    2. target/mips: fix MIPS64 segment access checks
>    3. target/mips: drop hidden TLB shadowing for tlbwr
>    4. target/mips: add Octeon CP0 register state
>    5. target/mips: add Octeon CN73xx CPU model
>    6. target/mips: accept Octeon PageMask encodings
>    7. target/mips: allow Octeon unaligned accesses
>    8. hw/mips: add empty Octeon III machine
>    9. hw/mips: add Octeon CPUs and boot memory
>   10. hw/mips: add Octeon reset controller
>   11. hw/mips: add Octeon CIU3 CPU control
>   12. hw/mips: add Octeon CIU3 interrupt routing
>   13. hw/mips: add Octeon legacy CIU
>   14. hw/mips: add Octeon CSR window
>   15. hw/mips: expose Octeon reset CSRs
>   16. hw/mips: add Octeon MIO boot support
>   17. hw/mips: wire the Octeon UART
>   18. hw/i2c: add Octeon TWSI controller
>   19. hw/mips: add Octeon EMM controller
>   20. hw/mips: add Octeon LMC controllers
>   21. hw/mips: add Octeon boot support registers
>   22. hw/usb: add Octeon USB controller
>   23. hw/pci-bridge: add Octeon PCI host bridge
>   24. hw/pci-bridge: add Octeon PCI memory window
>   25. tests/functional: test Octeon III boot
All these patches miss your Signed-off-by tag:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#patch-emails-must-include-a-signed-off-by-line

(You can add it automatically by replying with it to the cover.)

