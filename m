Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243A2C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx7lo-0003yy-BB; Thu, 20 Aug 2026 14:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7ln-0003ye-5I
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:45:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wx7lk-0005cJ-3O
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:45:41 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67KIIvNY571537
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wXVHmcfZaRdzLjpu+141+qz88/OQecfK+hrcfheyD6E=; b=MbeR/LRdJb+C9nX0
 S1XSp5/ISii1jmpcYbddNtNyCxDnlLNBLvLUrwGWbkWQBMGWrBwNhJu0P3T7cPgy
 8YAmixfnSfof7o3kqYrwO6NkeHy+MBH5TtiudY3SqSM3MA4jjKeq/vyiaU90y8Yj
 kM+J0l7qYTdfjpRXJ30VVlCtafmQ5E6na1elBg4tjCz+ilVaKqB9oXyK9r+nCy2Q
 Q4GdSBRYALxwSs/kuN4EdHjuJCFYgLihV3waAk8yd810OjaV0rr7Wa1cJYGwMgD5
 ruOXrzFezTdvQzkZAVVt92upmksmRWSMQMi7/XwdOyA1oNy/7djRi637JEY0Ud3U
 rX9/vA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5xgcan7s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:45:38 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dde0df80bso148425a91.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787251538; x=1787856338; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wXVHmcfZaRdzLjpu+141+qz88/OQecfK+hrcfheyD6E=;
 b=QrlN2ax4+S4OpwzesjUyZfZyrSJdR1qdKBZR83myqBYqAi9xj4X2ymeG88EX/ibB2Y
 pymOzDPvq/DZMkwVOFkxbFF/7N709pcW8DQ7vf9fej+siZkHoth2Gxo3m4mx5ub3Gfm4
 R1sdX3Qvhm6i2btnuWQmfAqGRpE4dCacAvfHYkGTY0bWxv5mqL7nV4py7BduITQ9jlyQ
 VYskSfMrS+sPL7ZuF1r4AoWKXtuxsf9uzfGVXDqUs4pQ9DOZ7M6vwtiRLSAu6MHh3yAB
 vh14hIXgZYx88eZU5UUPwAPQdU7OGOwsGewefb/sOzg0mxYyyzZ48eCr+qGO7cbyG3Nh
 Awsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787251538; x=1787856338;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wXVHmcfZaRdzLjpu+141+qz88/OQecfK+hrcfheyD6E=;
 b=Jh2MVVaSzSkiI9PoYf2G+37gg3pwcFyTiPbBLjlY9U/W7hKev8I3J3OhR8hQPMSXkb
 KJPaaJzgJaK0R43J0wP7yo98yXbxw1PYLbe6wu5jKIMrdfTgVg/CYbmEmO8CjzxLUT5M
 N39adu34xTi3sP0E1VVqLyjO3aGJR6QGT1eykN8pwFGxbCrbIE83tyXGH1wStAWSJlFQ
 nlK9dyMQBzPVyii51y1Po57BKJB0f1NUdB/ZT9FXQLIirhcsvdMGWhoyghq1s23JVwzG
 G9/w1W6PJv+kKvkhjZx+07RWatMNeQGmd6h6H0mSo/Ijin6QheY2cJ73v2N0fRsfH2Dp
 D/MQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqYzQPHzAyj96UaWAvmi0UKMhdslfIdMTy09UE1haYhPLjr2cQLMAQVlHVJg7DkUGQC63ldp5QoCDaw@nongnu.org
X-Gm-Message-State: AFuF++k3D0W6Rm+/v1Wq3nExxdWnDCnqbsVxLbQDlUH97mHDVLR5dXA/
 Fqi+YCIMtYB8/qIxPJZtWSFBVZKv9boOfNB21BG7Vnf9RUoLCd8qIlke0uUAsNvylBlTLDLQFxV
 MZXlylNuks4s/sO1PVJGlWxNreWEqcdabGSD6FMxCLdRiEUu2OvXecaPKyA==
X-Gm-Gg: AR+sD13kOpu/wtmSq5dzDk7RbyJMaiEmsYFMPaJjQmgPmKZD+3H/PEQY3qmw9m7CI/F
 Gc3ElU/4nzmiKhx4zUMWvt3lwfvbxlri6m7sxnZwrFEXhAWQcylIlOR4qGV0g2c0wHdctx6kjpy
 qH2/98alaQX40U+2z3LQrnyKoGXlVRP0VtaTuIJFXiHaA9gFNQXPMK2W3dKwXpgJ0zDnG6UYAEy
 uI4OWLQdHMFFSdfYjRMsAQBg/LwiKhGLhusIkpyaxiZ0yFBPdr85L+LinKqeUQhJgV4PjqMnIPP
 i03mneJs5CT1mNOCxSWhsSUCCbZk8mYFO0uxAYKO0xrtH3VQqcE+LB/XNaDMZEvJzOBsROdifKS
 Hxpaw1K4CiXb7FiGRAo0zpv3HhfneBkq0yaHUyM7zIbGoUpYFlpucnV8izsM4G0Lfbcul
X-Received: by 2002:a17:90b:4a89:b0:390:8361:a532 with SMTP id
 98e67ed59e1d1-395c33bd6d1mr1106832a91.7.1787251537611; 
 Thu, 20 Aug 2026 11:45:37 -0700 (PDT)
X-Received: by 2002:a17:90b:4a89:b0:390:8361:a532 with SMTP id
 98e67ed59e1d1-395c33bd6d1mr1106729a91.7.1787251537032; 
 Thu, 20 Aug 2026 11:45:37 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad564bcsm20237447c88.5.2026.08.20.11.45.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 11:45:36 -0700 (PDT)
Message-ID: <cb8d2eb9-8ff8-4b52-990a-85ecb2235ad4@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 11:45:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] target/hexagon: take BQL when reading the system
 pcycle count
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
 <20260819013144.3264096-6-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260819013144.3264096-6-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=GPM41ONK c=1 sm=1 tr=0 ts=6a874b52 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=03wZY-MIjpm2ANNGR2sA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: dBl5wcvb8XBGRT6PJD2EJhu_BDPlx2cw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MCBTYWx0ZWRfX8iNvXYxYT+YP
 oXKviz8lO03kKd4IwnSFhjBtfiTfdhHNV86L5XoUnpPCZc5p8PnMDiE9k6Lfn+PX2RMgV5WpXW4
 1lBoS0TlfGNFDTuQGCBvZhxQEN1FAiC5tEsqqwtYPpP+QwxFvnK/8Z7UKKynBUj9+kOzln82uLo
 lVVfMXQIhmFLvpHjpU9k2QesA0puhLmIZPAfmlrAWAOuG7Xs5J28XbAP48uknggWH4JhZOBQ89g
 4vyt8vf45teI30NChFyHYrA/34Qq7qZexsIYCG59DG1v1X/hdG/e6i19IFJgtVTKFJumURbzwl0
 cppCSAIJyvBdpi/EHJ7VgcQNyCTNDiTyNltuvHjP+jUUtr65t3uzebyMaiJxmPAF+Wb8r/G+HEZ
 KSnNwiD7PkfLZc91ac86ju006nPmPKH1AOjno1azKRneXjP8VdRDWoJaTO4h2er3YPV1O4v8KmK
 I06cI0qLam4yhTtMV8Q==
X-Proofpoint-GUID: dBl5wcvb8XBGRT6PJD2EJhu_BDPlx2cw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0MCBTYWx0ZWRfX4uXUDkIOoPBa
 rE7UkZJIKhfPlUNL/bUSVhxoNIirGrj/KqsRwuiDaCwqdZeC2/kO5dYtaUIXRKuyWWS76vKvZWS
 MVLiYpbP0LCmSNHOzM1YjyszZ2xvoN0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200140
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 8/18/2026 6:31 PM, Brian Cain wrote:
> hexagon_get_sys_pcycle_count() iterates all CPUs, so take the BQL with
> BQL_LOCK_GUARD() instead of asserting the caller already holds it.
> Convert the matching setters the same way, which keeps the locking
> contract symmetric and makes the read-modify-write in the _low/_high
> setters atomic.  BQL_LOCK_GUARD() is a no-op when the lock is already
> held, so the nested guards on the guest-register read path cost nothing.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_helper.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

