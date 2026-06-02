Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78A2CD6E60
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 21:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUWKw-0006ff-5l; Tue, 02 Jun 2026 17:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wUWKu-0006fQ-NU
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 17:07:44 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wUWKt-0001bV-7p
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 17:07:44 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652JqWEN2767170
 for <qemu-devel@nongnu.org>; Tue, 2 Jun 2026 21:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4iHHYoXpjE8fJ1gc39/cFxirDyVTsG4njdNuPZRnSZI=; b=L6auDpVZprZ7kV2r
 d7odZNC+QvAIUSkNfuAyNF63pPA5IwADY9xFoCA4vJivOdz4cxQSW5GhyeQu46uN
 KqeoqrBqMxmn/deiq74+zmtcS0jweX4xfBpOjI00JpNd5nAWgTat31++JEQFZb/x
 QJ9bAZ+iA417XZW3S17tR+7OW2AlhjN8JxNlSdKnNCIvlCQF/4jS6oXRlUwfM0Fw
 3Fa1GlD8o6qnyceQM8SABTs4/nd6dtsoNWCn45v7wEjJaVedhdBmxYYHUTHx8leG
 GClglY8UvQ9qrh0VT1InDkMR/pL9AbZsbgJyOnKCN4DEDrh/gR6C0J299ouW2s3n
 PkWKTA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsus3n8g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 21:07:38 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-13709ab38a8so12782915c88.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 14:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780434458; cv=none;
 d=google.com; s=arc-20240605;
 b=XkBgOS2XJjVeh3HA5Y+5NGYUhByOfLoEyiWDVxyCZDB+5K3T9tOIOhK0X3LH5lk/u8
 0hp8bmM1fn22k5+OiaDb3npnm1YaHFRNUE8+ti+tAqzkwWO0uZElixFBFrnEMBS9sLXU
 Da4+irJQLAWz+Y73wtEkS8Ov8h6GxeRliD02je2QegEKz7ya4uo99LaaKdJP616Sq4f3
 Yr6CVfY5iRn45Hbm1MMc2HetY8AP1kyQtqGyQnIIrnFAKG/O37pYTbteOFDtzmE3dYmO
 ivyhALDuG0ChsA52obzb4BBBR2H/LHDije3vAjtAQyZWmvDDriaqqR/+Y09luQcqYsQ6
 fAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4iHHYoXpjE8fJ1gc39/cFxirDyVTsG4njdNuPZRnSZI=;
 fh=qJ2GJ/9ZOcr5aToxR7EVoH6AYu+fsmuCJ3dJL0eO2kM=;
 b=GcB6un6Ap4+tmwMp/bTsNow8ZhoGQ9waz5V74lsJi6FWFd+b8decIgkctBrgNH+l0K
 5hvZ0fn4Ji/D3kMYYDIOpMur7z0ZzO4QY6nsYkqg21lx7kYlHIN5m7Gh/rFMkKTurp6F
 YI3TLFTki2OO00DNOCwUdm4nsWyOtncCysjGOAbOuwR/r8YGVbJDQZEv40zQ68eh3BNx
 8RAD2Q1gzqrVOmM94HkkciVwvGlFJNp4rkuo6oZvfeqnxoV2ANxnDborY15Pf0WjRQyt
 9WbU35X6ZbT8bkoqqro86L3DAVgD2pEF7F6qEu9mi31+75edqWD+giMVAmk4k9HAFFfW
 9J4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780434458; x=1781039258; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4iHHYoXpjE8fJ1gc39/cFxirDyVTsG4njdNuPZRnSZI=;
 b=fgJ0RRIOqm+Qgze2nPewKp/a714CRBsfR0/N4seN5vU6SG817Ii7fIAIEt6USxotze
 9ogJc8qph7OKzqhQ0tYCQK3GbpLKZf2UiVBqkuleTtpRlXQmndMwREeOucNZ1X0zRT6X
 ZYc48fMrkQuNM+cQ2WhbqqzxrVHhz4snC3sJoczAdT4pEajtOuZdpbNK6EXu8q96a4a8
 n9lRY7g8QhG+YhgjS4FiirPOlHuOm1m8iXETHsBGjSxpELOHc6xYJG14AZojA70jDp9N
 63eSVvPk6REwLvJECzhZLKR23Vc0kAOANFI9S6GgA1sDmAMLfmAFZA+uGL2iwvUp9h7X
 1vRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780434458; x=1781039258;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4iHHYoXpjE8fJ1gc39/cFxirDyVTsG4njdNuPZRnSZI=;
 b=SrAzIrUHn8beG/gOUt5t8lt9VbyhCrw0ve4ABJbB6+UhMPndcRr0KYDoj2x9ZpHE2+
 zZ+9HCLzzono7/tbE6JmgLSR95nn/8sruRLuZwMaBwG30cCnsY4DU+9rpYEKQ2+BAvnz
 uEWfdt+wwnOmwNBTH4qNlhb81T6Q5nb4Kt0nDvbkud7oyEgZoDibU91f78wQKChe0ljw
 HoZPh42UfAvKT3LHpYNOJpYDoF5Vr8sh4QusjVbv+Bnsohfpcl+/2QUKdBqQ9jCO4MOy
 E9aJ6h8axlumgGVerj41Bmum+I50k5cASEthbSpdcQWYhFB2lc/bVcQ2bcbzkRRWtWE8
 qXDQ==
X-Gm-Message-State: AOJu0Yw5qFsxQfjBNvyiH7ctNxH9uKa6gT7rDT7C0LB0ESQSaE3pEolz
 kqS+d62VxirDQogV3+6uyHTYkWiewrJNUlWhq+hiUl9DzWbAVBGzvQEoAHIeNNjxBv9PNkiRpx1
 m5Bf7mL5Nnk07Tlvkr/ByNYHQ2V1fboFk4DA94YYfNuaJwrjGUwPb4gtK0+GK3ACHZzAhHAU+6i
 PUdvgWrhHQebXkCvEDTxsAJ0O4IFRwsu1l
X-Gm-Gg: Acq92OF8Rn03roB/bwRZLKF3a7Z4joUKu0XKzumKX2io51rBxpZCpjk9WwybOf+3wut
 8EfDWooeUbRVfM4cUQIj3ZRqK/DCc5aUlT0WxhCoDYVY3DBbIpUGvlr6VyGZFKJBv/EfABmPu4u
 md/he/ONayQItq4d7l3JwAw8tQeZhKKuU1YR2jce8u6KX+0TiQQL77KAVXgOjThLYw8kb85mgBL
 sN7LQ1BDpumavZvYw==
X-Received: by 2002:a05:7022:b8a:b0:137:6781:7dba with SMTP id
 a92af1059eb24-137f6c0afd0mr177831c88.23.1780434457755; 
 Tue, 02 Jun 2026 14:07:37 -0700 (PDT)
X-Received: by 2002:a05:7022:b8a:b0:137:6781:7dba with SMTP id
 a92af1059eb24-137f6c0afd0mr177786c88.23.1780434457205; Tue, 02 Jun 2026
 14:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
 <20260529215554.606133-36-brian.cain@oss.qualcomm.com>
 <b9a9fe50-ca85-47cd-9672-c56f2d51f3ec@linaro.org>
In-Reply-To: <b9a9fe50-ca85-47cd-9672-c56f2d51f3ec@linaro.org>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 16:07:20 -0500
X-Gm-Features: AVHnY4Ll8r-kMwIv3y624O1gDYHpNjhL63l2zkwp8ZSjjPksU6LGFCqsVNSbOSA
Message-ID: <CAEqNhNbeLv3QhbhUTSvYTO3aDBT+bsb3DRFm7Bmoj3jWJmbNFA@mail.gmail.com>
Subject: Re: [PATCH v7 35/38] target/hexagon: Define MMU_INDEX TB_FLAGS field
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: y3hNJ05eHcfPRuY3-9ZgI5zd8Q4w0A5i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDIwNSBTYWx0ZWRfX70UKmdmkwCho
 mwUIB2T9hZqvqjcoB+GmLNRn0qJvnxK127G9EYOuHmDW+DebCbrm88uw8f/ZDhjI7YKZojOM2fQ
 uoeiFybGiHs6+rUldGIo33wtFhxRnrHYmqq4UB835bjoK3R3JvUIOdkilWo3LSI+lUWW3XnNBId
 jTLh94cqZE45ubp3wOLBpdu/pTuv4u31Fx0jH6taU7P4wZmrGEPkzpu9je60+1Xwt67qn9cxVm4
 DYcUXYn9kqcGyXLc/+j6/z8vs8uEwD1Qk0ioSGE9B71lxaU5J+F5pGwtBs5bW38fp8+5lajeZex
 jIWz8Aua8hoL1iu//R3Pirm7h5w3W5QsGzOrPzK9smJEWz5h0fBEr9eCDEjjo+mo9+UtfhLs6ZC
 oChmcpyzswVR3P1G6L4V2MQVtt6nVPMqSB1b5e7fp/4SzKVYjNIclXnXoBC2or2vK2YaFrZy7kP
 cpVyjyyW+rltweuArRQ==
X-Authority-Analysis: v=2.4 cv=ZYAt8MVA c=1 sm=1 tr=0 ts=6a1f461a cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Jk1Mq3RG9Jm1FU1F0FcA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: y3hNJ05eHcfPRuY3-9ZgI5zd8Q4w0A5i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020205
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Sun, May 31, 2026 at 4:33=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 29/5/26 23:55, Brian Cain wrote:
> > Declare the MMU_INDEX field in TB_FLAGS and use it to extract
> > the mmu index in translate.c initialization.
> >
> > Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> > ---
> >   target/hexagon/cpu.h       | 1 +
> >   target/hexagon/translate.c | 2 +-
> >   2 files changed, 2 insertions(+), 1 deletion(-)
>
> Squash with patch #33?

Will do

