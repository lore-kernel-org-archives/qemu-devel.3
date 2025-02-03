Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87D5C02196
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 17:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tezps-0008B1-VA; Mon, 03 Feb 2025 12:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tezp4-0007sa-AN
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:01:26 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tezp1-0001gD-I6
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:01:21 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513BESSe002245
 for <qemu-devel@nongnu.org>; Mon, 3 Feb 2025 17:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +hU6hTla9/cCvvqx2g78F/3wHmwBtxGxW/UL4sEwgyQ=; b=l7yOVZ0Vp8dfx0mB
 UZG1yUcfMGJj4NhlfqMYD4Ljqr4h7zi098bbUhij7/SsvzrKbwtycEAJQr8U7ee0
 QKzpXo/WohJzuya814cSi5ayIeGQEPVTFue660HcbogGklfmKQaxJNtdR2rITrpA
 DMEe7pNpeNTS5V29vIronGqe9cJ7aUGT1c/Nee3VwWd3kHoFYuARislpV34eHDge
 fLoE4pne7AmIEEBSZOAtj/OgCF9sFw21PGQvb75eMxsvL51ry0r+nkkuud6SUKlf
 DuG1dj0c7jCOT8+H4xu3LdwJmsm/5h8BC0wjjhvQt5MCWWCqYyd68rXxzQmbmDOF
 dq+xWQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44jvrkh067-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 17:01:14 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6d8e6046f0fso71436456d6.2
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 09:01:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738602074; x=1739206874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+hU6hTla9/cCvvqx2g78F/3wHmwBtxGxW/UL4sEwgyQ=;
 b=ioE1BZ1HuZMhjqk11C/LW5Ji6Djr6VdoA3IrLFf4+wp5/ceQiHaZVHgJVM6A9zVQ5j
 qyRlqULv8kRA7nDPpkcGX1L5vGQiFPCfULWrXnl2JV+gkA93ov+nKm2aaJI5kEaS4o0K
 ELQd5vB8S0LduV2HmTcLC0tyaxxwjd9Iaa0+a6+bO3hXk2MzvSN02QhypfgN/r2htYiG
 SHdfFWS/EI0BW5dgF6CyFlndDZaFQKh2V0sIf5EH66NarjKAlIBMT1V6AQZC0QNkSsp7
 tHSnfjhQ/599McgUC2gxRLMVp4bN7T0VoA9bPn4L0sP/OCrwZ1H+MoFshqPp2Ap+xRW8
 aKEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8zLTmY4QwkBSUJWECmwe4TH8eBaNcmD20jjmcnmvsEPBurKvy4HvEdzYu9JU8e0GkiiEwzQnQ84po@nongnu.org
X-Gm-Message-State: AOJu0Yyq4APtu9j87cCtL0OfrkmtWcXrSwrS1BgV1Rrt6LFMMKNnVt3S
 7XXPH2BifeyzxOkKwD8s+erENsLZTyhAQ2Y6wTEKzyd1MaAY+OsXtX7Pb4UZf0dAWqaOZTVs97k
 9/YotaTjC5yTzd2Hzi8lqEjJpKnjdYed2q0OUefA9FqEbnN6H33YgMw==
X-Gm-Gg: ASbGncsgObqBkK4ePyosRIdj6ycqfMbXirkymwPdAB4Y7sOkya+76LWI6KqJtYuTrYH
 rxvrj925Qz7WqdsqT7yDTZv+Mb3Ds3H8ZIRjv9jE/obaHgKyKTuWAUXPpDYQ78Sqwcv7QQXGn3W
 sVMvHrZQ9hfLimjOHW393T+rfhzv1Jyq5aI9mRXhD2udSdzoKLzbJUtzXL2uN8X/BErwKztLHdK
 X9TNVIVvDzi/H+YBgCJCrTgfuMYHh44hRcX9PqMDVat656mk22JPh3eDDBKnYKnhALDcgPIw0n+
 ce4Qhe3wkJiSumen6FPPRb8h/bSWV+mU0G4R8Edv+KSAsgrGlE3xIaBqWEN6uog=
X-Received: by 2002:ad4:5bc7:0:b0:6d8:7e03:c434 with SMTP id
 6a1803df08f44-6e243c364c8mr329253726d6.20.1738602073372; 
 Mon, 03 Feb 2025 09:01:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGppm87JcGFOcrSV92Dl796Gv0kjyHE0YABUWWoFJJzEYUsYNkBJlAkLqa0FObu3S9iGbSTrg==
X-Received: by 2002:ad4:5bc7:0:b0:6d8:7e03:c434 with SMTP id
 6a1803df08f44-6e243c364c8mr329252746d6.20.1738602072534; 
 Mon, 03 Feb 2025 09:01:12 -0800 (PST)
Received: from [10.222.168.90] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2547f3e27sm52357446d6.17.2025.02.03.09.01.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Feb 2025 09:01:12 -0800 (PST)
Message-ID: <8356e201-6f35-4d61-8a3c-01c94ac475ed@oss.qualcomm.com>
Date: Mon, 3 Feb 2025 11:01:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU community call 4/2/2025 agenda items
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alessandro Di Federico <ale@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>,
 Anton Johansson <anjo@rev.ng>, Markus Armbruster <armbru@redhat.com>,
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, cw@f00f.org,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>,
 eblot@rivosinc.com, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com,
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Max Chou <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>,
 mdean@redhat.com, mimu@linux.vnet.ibm.com,
 "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, z.huo@139.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
References: <87r04j15ha.fsf@draig.linaro.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <87r04j15ha.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6GZS4mMF7Y4vUnD0heX_AranwH0qaVo6
X-Proofpoint-GUID: 6GZS4mMF7Y4vUnD0heX_AranwH0qaVo6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 mlxscore=0
 adultscore=0 impostorscore=0 suspectscore=0 mlxlogscore=779
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502030123
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


On 1/31/2025 7:24 AM, Alex Bennée wrote:
> Hi,
>
> The KVM/QEMU community call is at:
>
> https://meet.jit.si/kvmcallmeeting
> @
> 04/02/2025 14:00 UTC
>
> Are there any agenda items for the sync-up?

I'd like to discuss the upstreaming of hexagon sysemu - one piece we 
could use help is the "QTimer." This is a device which was designed by 
Qualcomm but apparently has the ARMSSE timer as an ancestor.  I'd like 
to get some advice about whether we should have a separate device with 
similar behavior or try to abstract the commonalities.


