Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8C2E64AB3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 14:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tITo8-000530-Rl; Tue, 03 Dec 2024 09:23:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tITo3-00052W-SY
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 09:23:16 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tITo2-00076O-5e
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 09:23:15 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B39qgGW025995
 for <qemu-devel@nongnu.org>; Tue, 3 Dec 2024 14:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 loL9GD0yaXXX4wyFSE8I5O1/akGN2cKek5zUbS5gSl8=; b=EgMWwvpGNbywyv5g
 mcfja/V/KvtyPq6idDNKSiZbs4eCu+hj2alzj2DyKCE6dydCp2JpdVCxqXP/Kn26
 5n5lTfc80cRLwu/k2qCtjvwEWp2S388AxNRU9ya9g9X5dydKL2xx5PnHmk1ziN9R
 9KtTs/Q21v5JFJiVQWAoPVKJ5z3Eq8IoqT//CUcyjfir/zB8z25UVDnhUUsNkGZO
 TZ8LV5y0rSPRpIcx/9ikvUvPXXsEhe59+ICqQkW4N7zAV6+TfTcuU7hskLLMXd15
 hVv79RYrsHs14RLqYvo15zWsUAS2jKLymeajaPUKZ0PFBCFWHhVwON0kb/S5GMRk
 EYMP3Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439yr9gm29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 14:23:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b677151a03so692322685a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 06:23:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733235788; x=1733840588;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=loL9GD0yaXXX4wyFSE8I5O1/akGN2cKek5zUbS5gSl8=;
 b=wvwHSE03HPw2l2GQyJAjFMX4zmvWOxOhGtWjr1kcx1vqzOuutG0TnwzXvjmkV5zKKw
 xuBCN2HnJzHG6Z9vjdkz/FCPwOx3GzDDhsIylb8aKQbOj4eJdp4wSRxI6G3j3Tr/xGBm
 KDQ7gOqMBoBrgiQS/uKPrq5DgzDpZcTviONYFkZI0EzejoSxA5+IJK6y9rRzBuB84j6l
 3oUelqnhFKon9qRiALfWHB2R+pOM/LEKKM9OfOypy9fAUMTcfmpSQd+JTL7hKFhOIC9O
 tJ1Ta78oVrIDw0tlNHSp0yzlagbO+hrTPF1F8B7rw6edNs61HEb/5Vp9VHP+QvuHYST0
 He6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPMI6fccUIXWuI1fUcdbnt4R2QfTFKF4OD2jVVe7//RqBEIDPvUfvv8yR7DJRvlUu3yMrgshUseSTl@nongnu.org
X-Gm-Message-State: AOJu0Yx9XDozf0L+dmAYIYPHhhervuz4YPylcY8oYi35D+O8e6dNsA/6
 ZqL8Z0Y80p2r1vq7oLHIXee0v1IwnhYJtRDFIBsqJnwgthskO1ixXI7kvYPnGREpJ+J3cfWOzoU
 XaJ+gRZKDYcNxLOVum6WZ6qlNr2Iz3holKA9Mg0/YVaa9jXDxIkEppA==
X-Gm-Gg: ASbGncslJHa4J4o8HQTwWvFZG5vvOZX/d4POkKQwt6+Zvh4KaCjZCleKoMwiRymRanS
 HLT+q4xaGT7bwh7UQaRRhi8mariWDM/YHf2rrZhCnoPeR/JmAkFCefG6b2TkPnnMH0CXGjRGkI6
 MYEUyun6bb4HsVOK4H7WBl5Z4dURyu8KKtywHJF7Neq4m2G05eSf9X9xWtOviEgfmh1MIomHf9d
 FwwcfGBy0rB73+9VxYx4XAo3htMasKJsHdvKvGhXg27s3c6GjN26DC2zh+XPQnYjg0Si65SlVK4
 8qFajjqVodUyTlczb8cqCoENd9yteAKnbYaLC0RhYIga699zuDo=
X-Received: by 2002:a05:620a:4607:b0:7ae:5c67:e19c with SMTP id
 af79cd13be357-7b6a621bd9emr362820785a.55.1733235788464; 
 Tue, 03 Dec 2024 06:23:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTHirvIdXIBeIp0XmAZVeDDFkVdL2UdzmTOm+4boFKEG8jmki5gm5iebwJnmceUYYQeeQf/A==
X-Received: by 2002:a05:620a:4607:b0:7ae:5c67:e19c with SMTP id
 af79cd13be357-7b6a621bd9emr362817285a.55.1733235788116; 
 Tue, 03 Dec 2024 06:23:08 -0800 (PST)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6849c5a56sm514068985a.129.2024.12.03.06.22.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 06:23:05 -0800 (PST)
Message-ID: <c559ec82-2ed2-4d38-93b4-9b5076181c9b@oss.qualcomm.com>
Date: Tue, 3 Dec 2024 08:22:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: update email addr for Brian Cain
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <bcain@quicinc.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 quic_mathbern@quicinc.com, stefanha@redhat.com, ale@rev.ng,
 anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com
References: <20241123164641.364748-1-bcain@quicinc.com>
 <20241123164641.364748-2-bcain@quicinc.com>
 <014e9959-4995-4bf2-9a2c-ace318673804@linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <014e9959-4995-4bf2-9a2c-ace318673804@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Ai5YK8eld3GEbDM1w8sE1EKGVsb7wuvU
X-Proofpoint-GUID: Ai5YK8eld3GEbDM1w8sE1EKGVsb7wuvU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 mlxlogscore=559 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030123
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 12/2/2024 2:43 PM, Philippe Mathieu-Daudé wrote:
> On 23/11/24 17:46, Brian Cain wrote:
>> From: Brian Cain <brian.cain@oss.qualcomm.com>
>>
>> Also: add mapping for "quic_bcain@quicinc.com" which was ~briefly
>> used for some replies to mailing list traffic.
>>
>> Signed-off-by: Brian Cain <bcain@quicinc.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   .mailmap    | 2 ++
>>   MAINTAINERS | 2 +-
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
Forgive my ignorance here -- this T-b is - stronger than a R-b? or 
weaker than a R-b?  Or wholly orthogonal to R-b?

Should I still seek a R-b before making a pull request with this change?

-Brian


