Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0791606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W30a5Qwn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K0DivtJp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJvQg-0002Ua-Kk; Thu, 22 Oct 2026 12:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJvQb-0002UA-PX
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 12:14:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJvQY-0004R1-JH
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 12:14:04 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MEFVLi4098326
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 16:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Oe234m3H7AUF/8KNojv/NCKo4m391Sawp+2JdN8QgoE=; b=W30a5Qwn6qUAYoJm
 OVnROFUNY21sZA746/WWcIG19SjwG3/PXGJrL8Sd0ue4TkNvVLEIRkcz59mFFE/F
 KkVy+3sQVbGDWG7NNyMDKm3wf0jaJWft04n+Y/gRZNxCP1hrdXsejn/WDqT9LP0U
 fVKyaIgjNVCwrng1X0t7G9OPmnOCcXQug+va1vjSD79Mwfu04/WW7zlYR9/kdTVz
 IFST+4SKgJnkGDboAwmqg1M0VEKuVU+SrUsjSMzng/Ys0tpm85KS5wAGny7TrFCp
 G4On9DpYw/X/mYQquz5VBoN3NOcwnPg3kckXKxajqui8agc9h5AHoIRaM6K0hthJ
 AaW+Eg==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq3fue-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 16:13:59 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7cc06b9cb33so5990137.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792685639; x=1793290439; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Oe234m3H7AUF/8KNojv/NCKo4m391Sawp+2JdN8QgoE=;
 b=K0DivtJpZgoCDTzN1lD+XBZn1WrDazunqawRt88uTpoAJ/95IqjtMCx+gHkKKmpqC3
 Q/Jk4O3fKiIi9jbnH0EcpgkVbG5UjLimNVcrI7V0NQbxGXE29omfzME9dtjTJCR/vddf
 9iO1RFAm17BXB315zIRYbOocfiEFXbUXKN35uKc8DUtZ7ugiWExIV/ZzaF/nIOLAXmeH
 iHpTsPLWjrjyZx53iqkhlCvYFGp6cLRK4Kd8+wnmggCVIIpOAycYpAbl4pATU7vbNm8L
 KLbNIS1YeJDAA3w832P3P4qo5psoMP82Qidzt7vSJDZQAcozCT9TKrdjc9D9Cg9IJ/df
 NAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792685639; x=1793290439;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Oe234m3H7AUF/8KNojv/NCKo4m391Sawp+2JdN8QgoE=;
 b=Elvx+YLXvKLBsqK1+5Nd+YibmPLJ3st2WJf5GYxMaN4DB3mcGy7Prxhk2pHwxzipkh
 QBpMkmzEpInoofNsn54g7C3wDr+jo82fiTsXX77G3jiHa9HGJZgCMtNxxdXlbxF85orN
 ykaKt1f3+4e4ANUPB+7OjxwEHWQqfWVZTpU06uDKrVXXKuup6VKJ/D+LAvVyypyEdElk
 i2l1LSDuPzd3Z2RffgrwjnCzS73ljfKT8tWndL3nQ/C2NK1JRq8qBKf9jOylX0gQdCSz
 OPBFrUln5/QlWg4r8acXfS9dNjIfSv/xG3JhGv4pIGDvxyqRAkcmhUyv1wXX7K8/hvQR
 qShg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJAAcSGTwBbW+5oFUekRnILdfqQVlWcuDv76BGUV5Q2jgZK6QIXqpapvpInpBqrwdRWcngrsam3xSL@nongnu.org
X-Gm-Message-State: AFq9FYI1K+FLx+zVw17sD0SjBsOhVDeQHq4oCSAKf3pGVp9BYwsw+Ic5
 WojMhbh1+YB0jX2wwWamY0enfmodrheLM7kDiGyJ/WA0cuQkAmAjcaGZiy+ZCpVFRDTLmSGbbWw
 B7P2fZ+tLDYF2nTussNzOEXzvWGZW6N0WZ+1LZu6noeM81Qf0u5JJXXwqOg==
X-Gm-Gg: AYBFou1toonD98lXPEnxeEH/eGof1kCSoj54D5U2SjMr+vR6kogR5MOcoz13SnBIcue
 F/M5uRrU3a5vtC6ZI5R3a68a7KGr4VuaUpYxHSIC6fCDMe98P6930PPJuiN0Q8uIZAlVtGYhM76
 u4jN3mGMQitUcXpQSAbsOOnA+lR4Lj/tCy5VBbzBOwa7HkEjbqXc6zKPRRDhQ50AO8EYKPzKm5E
 idOCiZZfSqKvzB7iRkEMQ52EJRc90vo+X0Ib7XEnx5ZALt207Vrc4HgzQkU7Z+sRJhWVgjEoaa6
 TNFKAhRVFLJF1Bx/dSgZ4WzjM6RtYKBNZRgzGE12B8xmn4uTynITYu8eap1A57AWTQ9QiTtzH6B
 0pagda9KOCLCpOzFjqA==
X-Received: by 2002:a05:6102:3fa8:b0:7c3:9a14:cfdb with SMTP id
 ada2fe7eead31-7cc926820ccmr2074789137.17.1792685639357; 
 Thu, 22 Oct 2026 09:13:59 -0700 (PDT)
X-Received: by 2002:a05:6102:3fa8:b0:7c3:9a14:cfdb with SMTP id
 ada2fe7eead31-7cc926820ccmr2074781137.17.1792685638885; 
 Thu, 22 Oct 2026 09:13:58 -0700 (PDT)
Received: from [192.168.1.121] ([176.167.83.12])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2102dba42sm6732775e9.6.2026.10.22.09.13.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 09:13:57 -0700 (PDT)
Message-ID: <6f6d3064-94c8-45dd-b012-dcfd09ca9ad9@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 18:13:56 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/tap: Avoid "close(-1)" in net_init_tap() error path
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>
References: <20261022160426.451919-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261022160426.451919-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: o19maOKGXCz2x3c-TYFWdw2jm6rroR87
X-Proofpoint-ORIG-GUID: o19maOKGXCz2x3c-TYFWdw2jm6rroR87
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2NCBTYWx0ZWRfX8GOAVdk1B1pr
 emaaOr3i7Q1W/MSrarKSiadzRYgJy6elhgxPNyDyvZ1LW8EijdECurGrq0csJt6ClDRkyvaPdmd
 6KVhZLbs8CXz3giBtakMFxVcpHSx1Po=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada3647 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=8cDJgt8GFf4w86rseogMfw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Nym24-sG8xDkFaldbecA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=-aSRE8QhW-JAV6biHavz:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2NCBTYWx0ZWRfX3ldaZqfCtPfx
 fZANXQ3LtEE9Nyk1Qw18RZQgbyUdJ+Z2klDjeQ/bOed/qUIK92fTZzPsxpI0Cy1BmxqHmth7Z6I
 6qtSmFsNklKo4rFrAp1LNkH4tVxqc1iBiKeuxta5yoCPz21uGdwkOSNnKu01iXYkWWTwfFDt2rC
 tcr90aXX7J0nLIx1EMwcIThuSNI7CrEx7196CWcX7kB5JBd6c/9l8M5QKZd0kBlHkOfNSmHE7o2
 IqvM1HqLp75Nsh00Z22mZ3yQTCk0rKqSy6jdNp6NtIA4d2u2Oai6w/hQijRLvAp1CW/ubGO4DAc
 suITpO8Mn0SWMiB+kYM5hw7sBihpaeNmZGFeaJITVC/KxWYc+EkDRt6AhEo1Y2mpfWyedgRe9Pa
 UBWjKM+Cwsnqkkks3cv+p4iRNdwKlJqIrCB+b3gZl+iqit0cnhE2kGje0rEvDIqMZUf3AQE3/3P
 mt/OOmKvAAloFIibzhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220064
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 22/10/26 18:04, Peter Maydell wrote:
> Coverity point out (CID 1660042, 1660052) that some error-exit paths
> in net_init_tap() reach the "close(fd)" at the 'fail' label when 'fd'
> still has its initial value of -1.  This isn't a valid fd, so while
> close(-1) will fail and we are ignoring its return value anyway, we
> should avoid it.  (Compare net_free_fds() which has "don't close -1"
> logic in it.)
> 
> Resolves: Coverity CID 1660042, 1660052
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   net/tap.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

