Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243BAC88E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 00:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4p4o-0005Jd-6A; Thu, 10 Sep 2026 20:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4mdK-000500-B2
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 17:48:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4mdE-0008VM-8A
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 17:48:35 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ALU94H972820
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 21:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CVKRVtAcUjT410GytfmPY04Cnh8EKJAeXusHye/0yGY=; b=QWhy9GbgrY7tVAJQ
 e0yxBYmCduZEwSuchBG7hCZt5yI77CYoHR9l04vA0B0QTBwjNOx3H3XS1KXZhJDY
 3jFOJ9LT78FhV1bdXfGSGyfFDt6nhh18Kk61qUWQ5rqaYrPYqQKmYId7FlkSIBQe
 QJ2HPll7PcUG1KBXFCo5R75WOX3r1Iy/UeEwSVQCfJbqUOFIPwI7Qx8c/vItMWlk
 sZj52kbN3rW9oPBALcfUsEZcOd7XPGmQ781USxB+mXm4UJMmMbdxZKvctp9zTBZg
 f75iS7TJchdheb+stBeu4YbMh0I0BvAtvp3QjgQBBiSVcy8Hu7Gc7ssmXQBoAPWk
 RELWkw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gksh8uasd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 21:48:25 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7e9e2db9914so1809916a34.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 14:48:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789076905; cv=none;
 d=google.com; s=arc-20260327;
 b=cVZlO7dPbmKLovcpYFN/gEl6w9L4COoGfTt/HvGq8xaJtNKPyFj8w7RUrMTiKaLTH0
 +YtoXxDbJV45KYttxFb6bDRpMHBYWBeZ/1YIPjdGfv9vkmcijC2Ax0wVx+KSGhgTh8Ev
 cXCiEmhITN8MgvuDe7JgQqzsjS6y15fRgK3dShU5AU2/YHMDl0RwR5uwbF0hai0D4MRs
 VqiiCwI9Z78JD41fAahJbr7D2ee9n7MsXZDjqTrKNW3Y+10OQnbUmC76oXfAynV9eJ7c
 D2Q/JHs84ukJfngjiA4TKXc865NwBQrEXMRDdOyq27TraywQjQ7dqIogmXwYw9H7I4nq
 vAyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CVKRVtAcUjT410GytfmPY04Cnh8EKJAeXusHye/0yGY=;
 fh=qg98UZd52pNVEuj/ZQwsxHLtQgNBn3+BQsxmg45i5+I=;
 b=bokxvxeD/DKkaAuweuHGY33Hb+jfQZ18r/Abxj7d3TZneWmus90q3x0zmTm0aR48dx
 xL7bfUKXz9n/s08rSWtW8PfKemtvH+zEr/njSMT+DXDlOOTQZNtNxIjyCuVR18VOQaov
 CJGUSLnZnIiAFb0xMjBe2i+CwnUy2elOHmSSuWFXqGE8CYz4Pfhy1QzpY705pTeTXVxr
 77rit9g3AjfygE0EyRq2Yj4Dyk2/67JyzFQoLvGjiOJaJDhzn5r2Y53m73lUTVbvfTh7
 zPJ5svRXeSfTPNhhEg5fif/xOMiJ8r4YvMOq3bjFKNfLtI4L/aZs138NOQp4JUKRAqyC
 gurQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789076905; x=1789681705; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CVKRVtAcUjT410GytfmPY04Cnh8EKJAeXusHye/0yGY=;
 b=eK8mesPGuZl6GLdRzgG9IZ6K6/hqwVrb5E9gXlU6cmKIt50QcoiTg2eygB5D6uU9gI
 6CGFBdNCbj65bzekpWFe1hZMKBfOXk/f2UkFyZ99BKoo5SqqWorMIOLTZ+SecKtdWbWK
 qDvS1MgTvk7cwNgTQmFjVZQLsOpRJ2SO90+AGFkJjilinJ9Q6Zji4iT/RL/JIFsnxIJ4
 s53kVJLCNpIjf6RbHDkQMoEkvLy4KCLCp64xsG4KCqJxHFXvxTPTeERLDLlVcsnRnp9l
 ErDPg5OrQd/c8HRWswmYbRgiI3pWMXFE3cihror7sDHQRs4hGladP/zB8QsWcb2U5+j3
 MUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789076905; x=1789681705;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CVKRVtAcUjT410GytfmPY04Cnh8EKJAeXusHye/0yGY=;
 b=JBujlkE4M+uqhyeAsyFSBOpe5nkKhS4/bN+d7aithC5lhJT67Rw6WhLgj6Pj7rb912
 /m1ex+UfX9m00XcTmrwDO14oiOIEbNUcLqEIJ9yyKYSsrs7PcYa8iaKN1Nd3U9zvfzLm
 YXSGWBIo1ZwK8MoUkuSlLhCanEywWWW5zPkAfS6V8FzQKGDBw+4dF2xGAACYQTHKrQHw
 qgce5T7tcjonxffhbKIx9WgEpn8NwNzIpMC4qEtsJI+oz/kJ5P5zHeTqL0qQ0HXpmEXl
 Fb+v2wJYwlBGZYiKrq17tMQ2KtW5X9K32vK66lpJR/antxhgYr1xOJrblI7l09LcRHKi
 +aHQ==
X-Gm-Message-State: AFuF++nr5wgd8TOWXbTK+vnv9oIQsNAZbxJZAofuNNO7g7kfvlxbgEb7
 6iPS5RoXQsTaGXchlp9xHnGxLio6f9498N7/8xBYVsnpd4b6Fzx8Ep8wcbeOUySh/uBvzJSh6L8
 BOTDyHPDL5BqOMQ52r2/oK2OhmDsBAW9gQwdW1Z6U1743UUwCNVQ1wpZW9ZDXHo+99xnPeYMSxD
 +lTi6pcgGN+MWop9phIY49zrJjwkSatFhL
X-Gm-Gg: AYBFou1gnB4JsVQVJ6eYot/dmvfBO8pOno91MPOeCM6ZoeyWewH7Uk9UXTUaBt0SZWp
 eE/pkmGEYJhuz+XDL5+73zaynFPm7tsNljedJq36SKPV19xktnj71rPVQV6NiSbwNYLB9O5Vx6R
 h9I0Sbp84++ztokJSXANY5TQqgax/QFs3wZEqhjEJFhZVM2p/kiR5o5E6aPE3F7/ophfT0nEe+c
 WptXejScrOt2KSkqg==
X-Received: by 2002:a05:6820:985:b0:6b5:ec2f:3567 with SMTP id
 006d021491bc7-6bf462e8bd0mr3114235eaf.24.1789076904703; 
 Thu, 10 Sep 2026 14:48:24 -0700 (PDT)
X-Received: by 2002:a05:6820:985:b0:6b5:ec2f:3567 with SMTP id
 006d021491bc7-6bf462e8bd0mr3114210eaf.24.1789076904298; Thu, 10 Sep 2026
 14:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
 <20260910153221.1674285-7-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260910153221.1674285-7-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 16:48:13 -0500
X-Gm-Features: AcwNN1WUpN6VkEAULmnq5L40HCgIpodyPWglkNf725-Wp7adLSFAP3UKPK_-SGY
Message-ID: <CAJ+KCYMEr1P4PKwxNsardJz47ajJCJZG6Ye8HiQLbK2cc13dLA@mail.gmail.com>
Subject: Re: [PATCH 6/9] target/hexagon: carry a base ptr w/HVX reg offsets
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 71S5YhfSX2vTJpsmALDhKr580wAtuOqp
X-Proofpoint-ORIG-GUID: 71S5YhfSX2vTJpsmALDhKr580wAtuOqp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI3MyBTYWx0ZWRfX2ZeK86/Qxjiq
 TkGJJ4V4KV07OxmBEJs7RnGJW5J5M5XfzUoinTMTTpeHcg/7VA1PRDZfGaT/d9w7b/pPjCZqNWL
 W7F1l9SRpau+t8iHGq8s65+izwWc12nc4bSGp/BqAwX3RQJiKyeALqFS1pSjuzdBuIH2lPdjad4
 Ehgld4ssrZlT0EshE8NOUKouXBfqalGxlW3WHuQ5qaseFhiaoIzIkBna9opKpBNS0OvAfzFuRS3
 VtlO8qD/6sxocl0z7BDfHiRSBPXtQGfqiDRgOAQiZOCIJ9pqSgoGdE5NVepFHAQOhr01Dcb9wDk
 5HAssV+nl7Q/XAX4uC+7fOBTUjItP5j7TQUUzUIb7x7pFciEvwtd0KVr++IaXb9WdWQUesBs0rF
 BJRRl6jMR2B/IlCdKEleemVWZ4rpAfwFDZ4AiyfJcrFKfmEAYtHth88ZRyTPPmUTuK8JD8JahxI
 uIl/54Czt1Npd8qkemw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI3MyBTYWx0ZWRfX8K5o/kZ6aAyO
 3DpS9kzSmUR9+YnA+uvZSCbo7xQxAMTXDrIkgFYhF1KbjFQwH65FMBxL6EXFeVZM8rcjJZa0ipZ
 OC+CmF9XqtnfRqkI2+JZAZNu2+TMysI=
X-Authority-Analysis: v=2.4 cv=a56lZkSF c=1 sm=1 tr=0 ts=6aa325a9 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=1-tvTWTqORzI2cFg1S8A:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100273
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
> An HVX register operand was a bare offset from env.  That works only
> while the register file was part of CPUHexagonState.  When it moves to an
> HVX context shared between hardware threads, its address is not a
> translation-time constant.
>
> While here, fold the repeated helper-argument pointer setup in
> hex_common.py into Hvx.decl_tcg_ptr().
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/gen_tcg_hvx.h  | 608 +++++++++++++++++++---------------
>  target/hexagon/genptr.h       |   8 +
>  target/hexagon/mmvec/macros.h |  14 +-
>  target/hexagon/translate.h    |   5 +-
>  target/hexagon/genptr.c       | 102 +++---
>  target/hexagon/translate.c    |  58 ++--
>  target/hexagon/hex_common.py  | 181 +++++-----
>  7 files changed, 563 insertions(+), 413 deletions(-)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

