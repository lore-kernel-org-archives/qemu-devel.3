Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3FACA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 21:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC1gW-0000NI-Qs; Wed, 30 Sep 2026 17:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xC1gG-0000Mr-NQ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 17:17:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xC1gE-0000U2-Qr
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 17:17:36 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UIPF3q3881716
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 21:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7Ok8toiqjUr1W5ssPUQX04ljkatHP7ac3Wv1GfJPK64=; b=Y+sFsSB3px9cmsmG
 jYkmZ37Om7mGmjgYXuSU43NuIWRy6LW83/QkfcmVOXi7E0K/RK3XdBaMXl9WJGV8
 sx/O16KpTQFGeH2pntWy/ynBpvIu/bKNvy4qPYbABGtXcslNEesAhP4YsIAom9R4
 QaQG6tj3+EYQtrGf+5FTKw/RnnboTteWsKxZ9eMeB3iYvQWJjdtrG1Yl9Viy8JvJ
 g2nrDEDKfCDmP0ycpOgrBLFoN5hLfVTby5L1m2ERV/e7boJq3snZp3PmIKzYO5k7
 4d9y2jttNTUQdO1ybW4mOytSYOjXFOgR3kuBmOK8ODyCKPi3Xb2/oJ2WjVa78npn
 aVuohQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h17pj8n09-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 21:17:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a0b66ecd9so900501685a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 14:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790803052; x=1791407852; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7Ok8toiqjUr1W5ssPUQX04ljkatHP7ac3Wv1GfJPK64=;
 b=WOjh6UNmA1x02cfhkh86DK2N4U2YP0QaBozaUlQMvaySr6HBkUzDMaF6yz8G2vSv5I
 oxJGYZBjZ22GRfGXTu0yXioqVblpt8A0iyDw03P5m6p9oXOjEnzd0YvP5E9azvNrifuI
 4uAuLCFTFiwPe6PLvGLCbjqGhX/YjS8Hb69COiwVkRDKsbSjU8pEf0vsO07SqOnN3bnk
 eggjOFVaFdEnkP5ZlIk6dpeKi16jroq4qn2/RdvYEwFxtjknbYel7PY8rT4cQfdqwiCc
 NVVbEuCZWzTOLNgjhFvKXFYsFNpVxl6zWvmlbMiRTq+hwaaT80PaKnI06kyynkRfpaRC
 1ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790803052; x=1791407852;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7Ok8toiqjUr1W5ssPUQX04ljkatHP7ac3Wv1GfJPK64=;
 b=ozxRlE7p6pvH//Z+ERqhzwrv/bLSbKdOwnfelZ91QWX2JYJqMQPDD+vlf7Kq5uiAiH
 RXNycvUBG8IAWnKFPWMHKzmxHtRHdL+QzibSGe9aollOizoU91s+w9H6iREP4PdC04vb
 4Qa9EOgaQxi7H/7HQ6T1ck6M4fEH1pW+r5y6iAAJp/GBaaHlWUFBgNfPHlHCKD1Iuclq
 8R5IwPdX1dQGhSh3YWMjFm7cpMfh0jTmsXNjxLDIyg80lTkVNnRanVagBl3XOcE/iI5R
 sBqTPhrq5lO5cqlr8+MSli5IykYRReQf/JNjzQ5dUTiot0d5DUvytJ9y39/ZLZSBxNwY
 5HXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx9jBIN8/srInoEdFsrgDZ6y1kMqyRsRZvftzyyKKv0UArzOkFPvq3qiHujW7kSSSM/gYM9OkVmtl+F@nongnu.org
X-Gm-Message-State: AFuF++mCASbZyyzwAgwYciO/iBPr0t4zc/i7Wq5VnKN5cVZbdIl49ZAv
 6cZ6dwSDsNtlBST3a2T1gEnmrU8mb+UHdXho4ma7gd2c5wZdkPfbCIjpNjsmQqUzag2XQGBpw5p
 OQWWz1MCxJkPeijid4QHGDkOlMkjBJcROa1WgUAoYvPKnnQnN8mA3majiog==
X-Gm-Gg: AYBFou1N+ClAfWOh1q6uPG5bEvLF7r8B9IQVO3LGolNfaTBsjmMxn6FJoWew/C8fUKa
 W/32yTInwSUs8dnMH7u6BDLYyNyeI7ycIhMy/0rVy6gAm+JX8KQgBxyCiwRHV3Ev2TYssOlTMHA
 EKXgC4a9CFhKyWEncDIwK5NTO4QFl+Ta1HFZqlpT7ArTp8ZYBY/UlMMj78RnPDdjVva1BP8UVKn
 HPHH3sUW9gj/tnCfxVgVsQPUvsPCA4yCUo9pffzoty3hJYHxXRu1/BVCNgnZAEtUu771BqcZPmV
 2vktD074kkLsHohc5ofBQgS9p2If5393XGDkbDCoNhBF1Efa3U67QPLDIVRKfzjo2XLHSCd/gMW
 sV/b6BEqCFtYJop5ZtLZ7v56G02NC8xvMWg==
X-Received: by 2002:a05:620a:2988:b0:93c:6534:d04d with SMTP id
 af79cd13be357-93cac185b4amr425908485a.35.1790803051643; 
 Wed, 30 Sep 2026 14:17:31 -0700 (PDT)
X-Received: by 2002:a05:620a:2988:b0:93c:6534:d04d with SMTP id
 af79cd13be357-93cac185b4amr425903485a.35.1790803051160; 
 Wed, 30 Sep 2026 14:17:31 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b0690c47dsm1739406f8f.15.2026.09.30.14.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 14:17:30 -0700 (PDT)
Message-ID: <f30501f6-c05f-4ad4-8b6f-35752928eb3c@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 23:17:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] docs/devel, AGENTS.md: a completely new policy on
 AI-generated contributions
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>
References: <20260930085433.830743-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260930085433.830743-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eqpKXYpX c=1 sm=1 tr=0 ts=6abd7c6c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=erDh0M6pUkYTI6IIcYcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: OFqaxDJTJ_NPhbh3rzkKGt0aF85uTBcT
X-Proofpoint-ORIG-GUID: OFqaxDJTJ_NPhbh3rzkKGt0aF85uTBcT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA4NiBTYWx0ZWRfX2YXu6aA3EI+1
 K77uO+j+gp9BxoQwUuI7dMhUGylrnT/d8yApMAtIV1lkd8ec+g1vosrJnZHVHAYw1OYdENnzPKZ
 BEmERM1mGEtkk5pPjvoxdZZSc+j2Tvo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA4NiBTYWx0ZWRfX9C14R4qaWPv5
 UrziHtWHTBC6y3S+CKYZh43rTb70YzlImWaXyjkvn4irfZ/OBKu50Q0oIjizqbkMYGBjYmQW/lX
 k0VN4lN3qhrLQ6nau9jCqYXfeBoT6CzMVm3CB91efxf1MTctVcEwnvrsxEG9kizBKpoy+g9lnVu
 hrm3faBv85ekzSoOWuXBBcBB3p5EnvBTVCC9ToyimA/aoKnSD4fDznUX4ymhkY7eei1HqxPVWld
 tfYWkBLyAlDj5NND95WnGdnbSi738hDiyRy/AEQYnlEKdhS4l+94JAv4stZrCm2T0ngwifo4U8Y
 rHc5dn/s7D6HtiRY5Qfj6HAu/cwEVLcz5DUwpyoMf/EaQq5V1U2WF7CwJn+KI/oTkCUOSvXIuBh
 y+p57Y7Z8CuJw/MmrmpPICiWfn7T/ndtyKNBfYq+mnxNGJuylMI6sUfN1L2kcd/5SobzWKbO62s
 tcCJg6twA6iNwzFMrSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300086
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 30/9/26 10:54, Paolo Bonzini wrote:
> Based on the previous discussions, I am finally attempting a non-RFC
> version of the new AI policy.  Discussion on v3 introduced interesting
> points on attestation and I think a consensus is forming.


> Paolo Bonzini (4):
>    docs/devel: relax policy on AI-generated contributions
>    AGENTS.md: add final instructions
>    AGENTS.md: let agents know what the participation rules are
>    AGENTS.md: make the human part of the design process

FWIW :)
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

