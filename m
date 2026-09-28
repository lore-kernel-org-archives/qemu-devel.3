Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43156C9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB7oO-0001Wo-Vr; Mon, 28 Sep 2026 05:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7o0-0001Tk-SY
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:37:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7nt-0006n9-7O
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:37:47 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9M8V02057276
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MlvBsFyEWubQFFud7IHk68cuVghtUXPuKIXMpTJ/0NQ=; b=h0c/fFW3aYt9HUgv
 vYNlzrsMvXU/BjKcf+I8o9dYeOQqUDGqhBfL4q1PBg1RmU0x7/K6cQ5y45FvE3Hi
 bsZyfwVtJAYhl0tG0Btye9ay3c6NLkgrFuFp/lXgeWPX05z7btmzxqKO7Oww81m6
 /iTmzomOA1bEJj+BCRcd/lQRx5bP+0BKcscAF28QCuEPBLX/YPrYb802AHngLYVu
 Hmdi5qn87RoNGteEllRnBlvZcqDapgVgl+m2FWApHp8jxaooFvkYDAE5RbBtWpZ5
 LxHSvnHhHGF0KO40X8EaJH+Sfq/NRsY0Eiiipd9wZJoTwHEswbO00gWEbB30wMCj
 xNzZDg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubgwy0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:37:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e82060977so539745385a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790588263; x=1791193063; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MlvBsFyEWubQFFud7IHk68cuVghtUXPuKIXMpTJ/0NQ=;
 b=Gr0/EOQK3lYvfwJ5ahtyCO5whwR/O2hS1DUklN9E57HcJNy0d2J0Ju1ifo8NeLE7pp
 ltp83BDuRLOkRXYnzpMEM0q6ZSUXTzvhbT5jGInDJ/9h7XbWvroMcA6Q5bauCJosCPTb
 HvkYKstXUiP2+HQZM4Uu1JcpHO4aYj0o4CZ1rd4Y93bn5TlIRboHrWY1yw3xEZC4WjMM
 wlqCnhMU9lFvuBhJeS+4B9GCsYEeJhk5hXSMkPvzCG/Q+ffEPplRcy5wOfSA8S0aydkS
 IanyRFVS3MnCC6bC81KSJsKS5nBAjfYgeaGhWlNKYwCT0MvE4ZF9eFE45KzH0qTYycCp
 jgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790588263; x=1791193063;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MlvBsFyEWubQFFud7IHk68cuVghtUXPuKIXMpTJ/0NQ=;
 b=p3XayeNKX7YC1QjgRHqFtChzWtbJfh90N+st8blny9aFosz5GgX8izIdMlBNnD7f0H
 mDi+Ev8J/AH3J8h9rQBIBsOyepSxusIO40s7MXGH5tP0NuUepIdCC49eul2RQDKa84gQ
 kChiQG4U9yehTBX6P28KT+IQXYf9O0gR3tmNexzkqta9VOBBQgHevEfDXAp7RttiZp65
 jjIB7IocfrqwME55KE0bP9IR5yEn6Wwu4jU+gVsSIaVN80uX6sBvMlYN6Hjp2bXjTkXa
 O6JUWjqkm+cCjt6kLXO9yB7hTElVSxaqYdWfqnwgvmQcFaxliYv44oayKNmbjZ0wGsag
 PCaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUbgvpMNn/Gbh3rjVlGiOqu8MEXr3UqbE72eWxlfyJkFk69HCFYxgJjqTbNx6QC6g98TEvH+ko9nBp@nongnu.org
X-Gm-Message-State: AFuF++kJdW/x7VtfrXMW7EX2vD8gwP9ri9itZM7wp9NhfDDP1I0HO63Y
 B8hbREBymQ2mhM7uFERSU6JDWoLDjdGTeo8sPReWK/Dadc+F9rnQbstyTPthE8oEt9XVSdqmOEn
 PdnGyrDWF2oFRw1jpsxpGJybOGvjoLJ0rkLxvahwJGCiR+TVUyFxSk8rWew==
X-Gm-Gg: AYBFou00G7+2fQ9TNkt8ymZRDHGB6irx3vpVDdObXNbjBcIkV/jbWdZ3Ast4Wcio/QH
 X/vii24mwOGGgWQEnh4lhK7cdlN/24LAKdzX7AKOU3ltuoXpwIDHe4YgwdK7qWLiUln72vhGFCk
 VLwmaFPEbJWUlDjlFpaBBcly68BujLA+1kDYk0seviNQVJxffHCd0+OQdCj3rz642D//gheza5d
 wWHX+/oXdPMM7P8Cm/98wsg5E38nO+/DvHJtli3XU8VPaMJsMPm2El+Ws83ex41oWnL/UdqWEmm
 06GBXp6sszENOA55dLDt1iN7TlWVRNCZAifIl/PYtsmnJLWBXOJvSzS2eJ2/gfK4IeO92WZbK4T
 ACddVJsR4js5AnhmjVzIZOtIqEfKqpfiG6g==
X-Received: by 2002:a05:620a:3190:b0:939:72cb:bae1 with SMTP id
 af79cd13be357-93c43d4e800mr1754389285a.24.1790588262711; 
 Mon, 28 Sep 2026 02:37:42 -0700 (PDT)
X-Received: by 2002:a05:620a:3190:b0:939:72cb:bae1 with SMTP id
 af79cd13be357-93c43d4e800mr1754385985a.24.1790588262177; 
 Mon, 28 Sep 2026 02:37:42 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00178174dsm119449545e9.10.2026.09.28.02.37.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:37:41 -0700 (PDT)
Message-ID: <8eac38a4-1cfe-4ee6-bbab-faff8d8a4268@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:37:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/14] target/arm: Add isar_feature_aa64_uinj
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20260925215004.456336-1-richard.henderson@linaro.org>
 <20260925215004.456336-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260925215004.456336-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9sKkWFpKduHNc11ZjaNf95jypj23llil
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba3567 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 9sKkWFpKduHNc11ZjaNf95jypj23llil
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfX0LaGVFoemUR2
 rW5HgouaW8SwdZoV6oVPGXRTFTViHeU7qxEjd1E8TKgL9RMA+lhN1ov1z3GWuHPvXlDB0FIJ2FS
 wPh8E52F1n4s6qEopZbkU6pQt5GeaKdrLLMp6Fsb06m2l6GszY7sThd72wPYjTYpnSuqkaDgB9Q
 z8byvcKW6UA9D8Ahr2emtCsOLCxMmOSQRdLeFxIB6ynUF4IcYTZxemxNrL28mY33zfF4SwKNhJN
 iB59WPUpW1AirXAFdxkTLoOKGW7BmaO/xHNA0BiFftcAAEESDyhcTCWfyBMoF3I5xlRwa2pRvaP
 uZwaOlYozmxLqTqpaA235FnF2XKTGDqkzn0x1PYaXF4xGRU+h/jtt1LO1E0x89mubAqSyxXlplN
 CCQQS1IXD1G6rVp6knFQRuYgQR+MqgHr/TH9yTgIWY8xpPvmFAEe8grV3IzIImPDmGIaNQSyIAy
 qEKqOPDXomuklEZsEfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfXzq5GUeHgsuok
 V6lvsm7bVSjDqjQm/xbJOeCHV7Se3pELzUUV2b4WSm7a7dsjmptPs/zNun7ijCGPcq01JoS3uc8
 0yiPQDCtlH3Pgwc9K3QfVHpUOldBr+k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280038
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

On 25/9/26 23:49, Richard Henderson wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu-features.h | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

