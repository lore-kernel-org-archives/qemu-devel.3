Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758FBC88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pgA-000165-9G; Thu, 10 Sep 2026 21:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4oRp-0002E5-B5
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:45:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4oRj-0007kt-L0
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:44:50 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ALTvXJ2127171
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 23:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z/eIexRO4cZhHCVa7BQj55Fl36yA/VPZn3JHN63/NiQ=; b=nXZ4P5d+kq6xID2W
 4lUG/FFnwcxO+DUMJc0JJTy5AYIUl3Dxc2PjRylzfypEmA5UynzFMuormm1UKt1d
 +hbAjuqNFxZA3ENHrBIdL9NIQvUqGE0DdtsF7ckOk1FAjxCSEuj9hdh+dTvwWWUz
 eudLysU2NZEe6ng76xQRcfZREhJCJnDnlgrXt1yxSYc+ZkDeQk8y8494vjzCrSeC
 xkPbCHYu1+Quv87eszKxR+Xrs67260UCZWkr9zCIdK3+i4szT7TVz94IXehI7dxf
 QRSBnPukxl8v46FBjilgKqHV68+VjcH4FGQKPMtIDCb60VoqcgLO95/JyKKnd1En
 rv08sQ==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkwkwahp3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 23:44:42 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-6b352d9062fso562841eaf.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:44:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789083882; cv=none;
 d=google.com; s=arc-20260327;
 b=Fr12b47zMbg+O9+Cf1jFrsQgXAQsdSRpsYds4W5YbB4Emwn3iMS5XfW+HoyxQTURwB
 elsv8IF7Vns7vFEHfOGwOCBIoagjFPLSMS97IhkFy49ChUKl/jMc1tEvKrokK4aZEZGB
 r7DaTxyh6G1xAvp6CV6+hRHxDkjSXT5NxncLnAqUXXzjzrDbqri3snWsDkRHMicUitZM
 0tzwluQDkKTpExT4EQ0b4y1U/46HbOXorwUgwIymDKROzO4e6hSjqtKU5kGp5T6k7c7r
 JQAOJnjFPsy4Ht1vtMvmmqdUKR62WqMDYezj3/snSiOFd2ZAtuIQOjT4pwqSxqkKfh41
 BRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Z/eIexRO4cZhHCVa7BQj55Fl36yA/VPZn3JHN63/NiQ=;
 fh=qg98UZd52pNVEuj/ZQwsxHLtQgNBn3+BQsxmg45i5+I=;
 b=Jq4II0ZM21uGIDtn8ECbsV2UfpAlULOZ3EhzYQeexGqw/JfNeAnpSOQNkiZuBSqFMA
 jGcUfMPKb8EASyPUakQoqQNBp74DXhGLzo+FEjVQEHoZ2mbi52UE+DxF9nYx5Pa0m4jG
 orFSP9zs4v2BNxmjyKE1J3PKScE0KiDyDpjl6iewAGQMq8lujQbyu381+3cXEa/snFXt
 OPRC9H36N9+e64P7omwPam0671IFpIGbF0j+ocVqoB32iH66u0nOyb+4ytzT1a0fAi6+
 mGMdgELd2DpV5ADOr07onDKzJ3LuJm+L48Hp+Td86q0v5rn5xsUrauFofDGzWw+V2JUo
 +UJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789083882; x=1789688682; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z/eIexRO4cZhHCVa7BQj55Fl36yA/VPZn3JHN63/NiQ=;
 b=e5RBLCor4KV319h7DG9+3l/K9AF25tYL39fjrf1nNcOmzyYrR+2oNMqH0/BV9FAQUC
 tWIlxeyQmnmdrccJ+8C0Xs8bCJkI8gSm75QV+6GVbmeCvkRe5UZCt+RzmjtHC/7fZNKU
 7Ufu4hW0FIQPdEO/wp2ZXKZvAvejWFM/7PAqFld3xw8Sib3jL0/f1Ow8vQkMRpLIEaQB
 RT4KaZ2oG7oToiv33D2lIfqeAN8sSASR3CPX2c15fEgGVYbG7zyHcDWckajiGiL+ZYwz
 +r7Igo/l5BImDXfHijoprYEE1ORGZHly2Cawa7OzyXz+f447r0XY8LOZoPSW7VK4zObr
 sprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083882; x=1789688682;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Z/eIexRO4cZhHCVa7BQj55Fl36yA/VPZn3JHN63/NiQ=;
 b=YqWj8FJx/qrB3//PKpnOrdhU2O+HXzLSoPSkH0Q4D1MuKhptl9kGDy8A+ae40wti56
 izL3MclB+kRcSYc9C+KzItgYhbSPeNcv6gNpc7WfkG+7bOQaIOb+S4SLqgVJHvGPmaiw
 fPig2IZ6VenlVEFPVg1w3VJCJe6I9a7NNjirlkV7pjnYJrv18/oEs9La908HKfRA66gS
 GGi2cWNIAZPw8zB6Fs8zUV2fj4WDxcLempeRKJlaYhPlZyWaLjd2qMvW32+rg40e0Z7K
 wIskaSdIlO7a5ABQrSMDEkGUw4a1rcyulX+dIqWgHHw0VcmfSNlGynef6/wgmYvB6hKl
 qR9A==
X-Gm-Message-State: AFuF++k4wiouAlcD2LN0HAshtQtA6+qN3AFdY7VKN/bkELZkx5mUzqvY
 3t1uC7dO14JF2hMzx03KNbgjCYfTL+rpqQo2tvJiDbTdSWRFFeScLNB4UoROu7MhrIm3dofcWn9
 WLkKsgH34CJQJ+dSz236Y3yqnGKgMXTLrnksFn2hOWu9c/+XzXpcp4XD039bSnwNCN988a4oVMs
 cfTgS/Zkr91MiTCpUeVn5lcHErFUZprec/
X-Gm-Gg: AYBFou3uCRiGUnuPAJXOZGey52Zm4wCVTMTyCtgMxunS5MbyEHBOO4L4C7Jxx18Wn2e
 X4tOt1tlKqrvPpIbMncSPA8xsobJA4RmCiQtLDnFAic4i0pJ1EeTatxgRafKHLedzObrYvo77WA
 Pj2uBX70eFuY02wFnLfdaKle/dVRuXoI3c2UrWlpKN7zBo0+DYjhv7/HYx8Rjts5Po0q8UM62om
 7+DACSWPQoD9IGpZg==
X-Received: by 2002:a05:6820:55c3:20b0:6b1:b771:bc43 with SMTP id
 006d021491bc7-6c0b9959fc2mr706489eaf.23.1789083881855; 
 Thu, 10 Sep 2026 16:44:41 -0700 (PDT)
X-Received: by 2002:a05:6820:55c3:20b0:6b1:b771:bc43 with SMTP id
 006d021491bc7-6c0b9959fc2mr706480eaf.23.1789083881354; Thu, 10 Sep 2026
 16:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
 <20260910153221.1674285-9-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260910153221.1674285-9-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 18:44:29 -0500
X-Gm-Features: AcwNN1UXTUEjIPCAc8KjriBLO7Aa93U07PDqzLlDWAGlrz97lfF1SuNGI3Ltn2E
Message-ID: <CAJ+KCYPb+en46bQs0TszcN7kP4pASyM+YWbYchdc_RkZpBETwA@mail.gmail.com>
Subject: Re: [PATCH 8/9] target/hexagon: select the HVX register file with
 SSR:XA
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=EZNd0/mC c=1 sm=1 tr=0 ts=6aa340ea cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=JI5STjkJDBzG3GyJKO0A:9
 a=QEXdDO2ut3YA:10 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI5OSBTYWx0ZWRfX/25NsrgNv4qY
 9PrXiaiwIwM+FJmT0qMVu9xFswaflC2f89s/Dbgnt/ahxLMu0/ayq0B/lHBgxzux6uqiJ/eKvPA
 koPedztofyENYvFeuaFu4h0KhUAJDtQ=
X-Proofpoint-ORIG-GUID: saqWQRPwjLHOIbJPj6yWHhnPlY65K7ne
X-Proofpoint-GUID: saqWQRPwjLHOIbJPj6yWHhnPlY65K7ne
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI5OSBTYWx0ZWRfX/AMxRtqpUfgi
 nWBfgQsjC/4WM2odJx5e2To3pZxWMCgOYdGlvy0kII7dFvjTYXp3m7aDeJuvd01Wj+/NF1hChBA
 qNx269DVahF/D0gsmjGbRqzVJ41naLQHqKVVhAPWhFq+7a4IqmkehvP7/ZP2odAWTh1lGyy7r1k
 Swwqn6IQPzTmAvZB1hEJIgXxIw3YM2iL1/CMNMkuM9TWN3mdRW8dJxXcEM7+Qk+8QWXarawlwzA
 9Jhz6H3oZ9YpqiP+Yik4G3f8PtJ1DCiRdYea7nVPkSzGVHX2dvysgUlH7O3uoJNRvzWO3tJ1iAS
 39T3g/mzEEq4SZPt/Qdnw0vZPvVYoLlACi4uK8fnXTqgFXZtkReRmthf3T8/pQSuXgmo9gkYhh2
 /nrqvheSRbdMouufOL07l70qiiHzQbySKLFGL42ztsnVTMFWMXVvOQLXToObmVRdJv0tH4m+NRL
 vCleNMBh/D5YDx5yWqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100299
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Thu, Sep 10, 2026 at 10:32=E2=80=AFAM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
>
> Assign env->hvx to the right context when SSR:XA changes.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_helper.h |  1 +
>  target/hexagon/cpu.c        |  5 +++
>  target/hexagon/cpu_helper.c | 72 +++++++++++++++++++++++++++++++++++++
>  target/hexagon/machine.c    | 12 +++++++
>  4 files changed, 90 insertions(+)
>
> +static unsigned hexagon_hvx_context_index(HexagonCPU *cpu, uint8_t xa)
> +{
> +    unsigned n =3D hexagon_hvx_context_count(cpu);
> +
> +    if (n =3D=3D 0) {
> +        return 0;
> +    }
> +    return xa % n;
> +}

Why is `xa` wrapped with `% n` instead of being used directly?

