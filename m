Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4D5606A331
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SUpUBc2W;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ix7s+HAc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVBSo-0006uE-Gf; Sun, 22 Nov 2026 12:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVBSl-0006tv-VP
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 12:34:52 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVBSj-0006qc-SG
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 12:34:51 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AMGUqsF412106
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 17:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 db1jJMihBkWuHilQMU4Ao3wLrZkahleWa75ctguFRME=; b=SUpUBc2W5FjpoYMJ
 OFhWK2kSZE4pF1gYMoutzKmSavxfjQGHqJ5cTokubhtph/DYD7dQiXhiHYEWCw47
 K6Q1ePs73kBG81XDfb5hHYJ4p3/M8Ocy3eHV4y/vM3NgZ35Q408YrvtoFlaT09t1
 Y7mV+5274Er2nZHFoDYew2/PvT6CWlA5BOySjJ4fqnUqe2/+y5gvEOG0D3TCwWiv
 //mOn/JtBnKHHF2hLzY2tGiLYhcxlNb1Nh4zveebfCwxAY21bJvRs0pjFz8F1jam
 FemcInXdDPZ3B70uIWI7yuVbS4XLKD99vBoCJS6BiE4HGRoy4EuZ/zY1yTAhLw6b
 +ve4Ew==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j32a6kxyc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 17:34:39 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9210ec7cb34so75629626d6.0
 for <qemu-devel@nongnu.org>; Sun, 22 Nov 2026 09:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795368879; x=1795973679; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=db1jJMihBkWuHilQMU4Ao3wLrZkahleWa75ctguFRME=;
 b=ix7s+HAcZBBqWbd8Wwz4SXiyBZ5S3J1EySqeux23V1Aym6FEHt9oKWUgQMdcA21Whg
 9RexKIhxoNA848mHDdM+CqRsrEU2FB5RPSiUYdQW/5mZjl6u83t2lGsaDB2YsVyV+m0a
 ieTQ67KVc/ucjB9+saO/Wgt+IAtw7MNLPqPzHAfD4oYexSOLqvEaBfgC8ko865A29TqJ
 a6/p1sfETojT/2VdBzSr4KN6M/e1FDHb6cuRwmm+kJe4UUQc3Glcs8EGHFDG6vtq5VMI
 L+BzX8u+FEdYBhrMJL0jSYQyiaWzf029CFWy7CCVKcOCLejWACtF88f2HhC5zJ2W5kbl
 w/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795368879; x=1795973679;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=db1jJMihBkWuHilQMU4Ao3wLrZkahleWa75ctguFRME=;
 b=An/JSR77/oTiPlmcpg9KBMdH/Fhpp216aXyABD8IOApyqNvbSPdggANzInNeL+rtwl
 Ok5/FB1KFAAFtksgaT8Os9SV2NyPkz8DDnaaylMepQtz06kjYo320dH6kL53rAL+nbPB
 PIdU0ayEcaFHuj8nG2p7Jf63ackJAdP5iCMiRMMKQ4N11+d+SEN6y319PChadZcDnGG1
 ss0M09y47Ne/CU2o9i0unFd93kmkajzya6Z+Geu4LlFTCTWn5CeBgj5Is/cLhhMjkYVf
 qll32MIiHqOFUDy3a3bxLth6MBcaurYEjH+sbRUNl9UGbSQvD99rZVGOLiarPLIDh0C7
 QAfQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH0FrNHwTrNG4AU3TxKhgCXy/DaE6y9tru4MIAtQKlrRk25LPNwtnn+OuLF0YL5pC+RD/DAe/wBqnxU@nongnu.org
X-Gm-Message-State: APuU4Z97mjQwqIqMJo3rz9gmadZD6xBgese27fzhuDtbP/kamEGQx/J9
 8HX2NcrSp8dXPl4beEgW4R2DzPD6xnk9pajK/bKt3BFBDMBlmUvmMs6dElHytdpqL7LdNXeiQ+G
 5nKVYnbWFSFjw+Zo2jU4cBhX0STmY+NF9BiDqGsYZ1k/0mcFj7QVXTJ9Oqg==
X-Gm-Gg: AZFdTZd2NNr7VZLGvBFpIgZ7IJoYXp+2XRGypdLwSK2F5Tu1mifFqHZgeO6RinP8Ukf
 0MDdCEimyUvmjZjDjFc3zAC/YpdRb0IHLYzOyFfy+xJOlKK9K4yIS4Y1swkhMQsD0FEwuBTiy/Y
 hlYyVWVg/VlBfR6tImNEGc5K1tlLYyMIjq+VNfby/x55eQUUB623PCZ1jIm/Q/8h96JT8mNZxsx
 8RkErK5juuPQIICB98L5inZ2w8m9BI1+yMjqybrkSGJshWoVBDUBoea4G5bWKWvPHIJrXV7uqlw
 Y964Fvu0FN29sRXHIb0sTSSfi0VIrFjMk2HrJ+KGiEVrvGXL8NiBNWpmJoOj3nMRG01VMpwYkR4
 +LR0AjOrXQSixuBv1UrD4IP8Rg9A4/jZxJlEjfM6WTpv0Q6Ad92owLkVvgv+4Vq4i730vjHdk
X-Received: by 2002:a05:620a:19a3:b0:949:7acd:3c37 with SMTP id
 af79cd13be357-949bab678bemr1593729285a.66.1795368879276; 
 Sun, 22 Nov 2026 09:34:39 -0800 (PST)
X-Received: by 2002:a05:620a:19a3:b0:949:7acd:3c37 with SMTP id
 af79cd13be357-949bab678bemr1593725885a.66.1795368878810; 
 Sun, 22 Nov 2026 09:34:38 -0800 (PST)
Received: from [10.111.128.153] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2c8csm18150986f8f.2.2026.11.22.09.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Nov 2026 09:34:38 -0800 (PST)
Message-ID: <d93c2226-00fe-4905-9462-13b319fd1bdb@oss.qualcomm.com>
Date: Sun, 22 Nov 2026 18:34:34 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/22] MAINTAINERS: use consistent capitalisation for
 Alistair
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cleber Rosa <crosa@redhat.com>, Alistair Francis <alistair.francis@wdc.com>
References: <20261120200511.822573-1-alex.bennee@linaro.org>
 <20261120200511.822573-22-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261120200511.822573-22-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -Avy5KqvVTh-aJ7TnEMrVA61WhRyOoDv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDA2OSBTYWx0ZWRfX4UZ128SFegwv
 fLtdIBaP8c8S+9FzQV9qfkjF3OZ/14tg7GmGdJ8aZzpIKp4qefhriNo4QgtM45Pk6H98Xhc3gKV
 o7NMAsDYAxrWQ2xErvzszm1X3iPrBhw=
X-Proofpoint-ORIG-GUID: -Avy5KqvVTh-aJ7TnEMrVA61WhRyOoDv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDA2OSBTYWx0ZWRfX/unlIaWfv7WN
 Q5hkGCttpl3Z8wq9iGe1xKDuGxnSiPlqHfH+C6ko9igM+14GqG5d8lnaXgUUNoNZhEDRy3vmibr
 HkxpwxzZSBQLf5+wjtM0mrjEAKAOr2k6ZJKrS3bRtMFIdJmy+kzK0S8sFvoaHHSpZ4k5Nqr7Oh0
 CdGJRSdD+KMuZ1qtSSujMkHGHbAcLCbwQ9R+0cAE93jCnJTA96vQoOyFYIQg8xEcMIWxr2Fx+4+
 q0WlpFl2sQc3DUerlgL2TeCTUct16o3lWlnQ2H1hs2i8IJO9FVutIoQCYIf3UEXyXQDw/FkF3Ut
 zC+eK7nAlzGVhRazch/srFbpTkVrTYBQH+ymrB7TiiCDKyIvm3nttwaBPPv5krRcszEe9+nUhPv
 4XXCb/uAd8gcYrLxBoRdART0w8iE9k7DqcNolRG6TkOBVm4COgsj8RAC0xBHF+Seik5DKMuWdOt
 rNxRFaeaMFmp0DKKIhw==
X-Authority-Analysis: v=2.4 cv=UbHE26SN c=1 sm=1 tr=0 ts=6b0327af cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=JF9118EUAAAA:8
 a=wRtgTbq_-hQExW_sgbUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_04,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611220069
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

On 2026-11-20 21:05, Alex BennÃ©e wrote:
> The last emails with capitalisation where in 2019, make it consistent.
> We can also tweak .mailmap so this sticks in history as well.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> ---
>   MAINTAINERS | 10 +++++-----
>   .mailmap    |  1 +
>   2 files changed, 6 insertions(+), 5 deletions(-)

https://lore.kernel.org/qemu-devel/CAKmqyKPSewTC3dkzCaZRu26f0qoZhvnr_RXPNuH9SfgxNuVcLQ@mail.gmail.com/

