Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2A3CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 19:43:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZwAE-0004xV-7w; Wed, 17 Jun 2026 15:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZwAA-0004wp-1t
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:43:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZwA7-0008BZ-8v
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 15:43:01 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HIRWoM3061789
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 19:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 u79kqsm5ZGk1ENR1PRPsT6q4wFnb98uoe+QW3MImRo0=; b=OAMrxQFrtZxDwQk/
 vaYZFtTMh4Sn3NYmUFb8d/rtnnj9O2OWT21a+r7+ik3yEx1K7+TERt0a8zpS5Xim
 gb0aMvmsbDpopUOfz2KirWh2PvXGZqvj2xGFZ09DKo+LADarj3JyKexT0XML1MWy
 Pt+HA8Zy1GjEHDsUJ+B45ErXSLusISOG+f7yGlOaMemZY3BBs82Oc5eKP3GSCZgN
 tuXzVRWrr2NVHVlp/EtPsL0jC/cfi24eVSGG3w6/jKDCXceWj2NPapwLqIQuAwow
 TMYO8Bvy1qsh7nh5ErZFALMAJv5ext+PDtgFFXcqA0NyVX1tFQ7qYFQHjxi/1Q5E
 cnOcGA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0vm092e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 19:42:54 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30bdfcf7c14so652918eec.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 12:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781725374; x=1782330174; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u79kqsm5ZGk1ENR1PRPsT6q4wFnb98uoe+QW3MImRo0=;
 b=MLJ1Uh6Wi54rDnr2ZH7M5wxFh4xiGsiUJ+Rr4C174Cyl9LxLk7PYrW6ChGpQa5o02p
 fhcfV/wOBe1LkfR6BY2VC9RlCnWTo3YtMnE6c6bMUW/T+17VOR5LS3ksvrvz6X4ADASJ
 +AA8Rposyvxa4gu3gp5PBeSGpxXMqT5CmEEmU+buMj4uRaxUQBlW+Jo6JxPgK7TVIElp
 V2EGK9A9+U78B2MaluROEHje5Eis1zCQ+nbyLSIxWHG5QuKYJjvMDRVD+tbTzJtytw8M
 YGBgWApx5AQe7S0hejYNbrsT1YCDq34l95nMEjTj/ZlEZ7Iu/xFLU3G1stKk1b+Pbhxi
 83Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781725374; x=1782330174;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u79kqsm5ZGk1ENR1PRPsT6q4wFnb98uoe+QW3MImRo0=;
 b=juRyhNDWSRRk0fn7C7Rq0h8LkoQBV8w5TuzY2cCOtC1SjUUqlFHceDxbMsqIV1BV+d
 1S7UqZWi1SxuTGFBzsRCSI6FRVO0fsUj0u0HYyf4UD8N59XTBWFJl32YvG7PZPd25xI2
 nK/MmIplE31v6+wf+PYsRqDhCupFLwqmAiPXohM/C9Fbq2vkqxynOb7PBA6MTtWOku5m
 gLTBdktqMGFdDva6Eequ6H0B2wwPqxpRPWG2gcsies6mdjMOEtaDjfHLsCEUQGtd/GDu
 ek6ypPAV55e6lGgVvY2Bz5vLgYTUU2fNy092KzQg5fzPImHOrqw6j5+fJSlqRBXOeAXn
 N1zQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Qbm0NsX2seu3Tv5fn86aoqAC1B5/MYf1dihhlOLo7bRM0ngqLIjag9whUQaDgunH/nLqKulF1Ar8P@nongnu.org
X-Gm-Message-State: AOJu0YzbseMUSAy0Tg1zi8pK5rr4TJZC5OO6gLAElLyNQ2GPsbjKAjnk
 jAt1PLaOwAubDgzGD2hZoOx6iGzvS2Wc6snremhGRlA6gAgIUSsoaGOadZEX88qBjEufIXV0p4K
 T94QDE7Ct1zQ15NYib7XOm1FSJxT1Q5DzTUxOSHylCdYuvokeh/N9MXYViw==
X-Gm-Gg: AfdE7ckzpq5LRcjvbtrtwvSMU7P6Ref8LfnVYdNzY90tHM+0GyGjpzrrh1SpBE1AcGb
 2utb7mZn2hTKZjDnbbgX15c3wiuuB+KOXQBpKBG35jVtaLcuf9uLxzSgtjwSGdekS//B2M0PA9E
 6uZEjOI0Z0Tj/tS1oCAZXKGkwwpe9urVNk4KH6Zr2gx3nbIjX3YcCZO2sQ5A+iQeilFVetjM0qe
 OBKlGXbQtu0vBKKlLxBiTgU543pxX1Tds7D9wrOc6A82rl7/EuzKc4sPYmhdH5wKIxy9jcDScAn
 YT55oG/bKWmjAxMF8sdCEWmjOCt0SECoMfHG0H39t5ER4uMeOydS5QX2pKUy0KSkvaIWMcTIOxS
 yjkCUiaJNylRUJB7C9KusHP2mKsjjwLJGa/rZ/OXZ7nGhhuB9e29eHjogQpxRXT1ZRJRFlFI3gA
 u+1qM=
X-Received: by 2002:a05:7301:10c5:b0:304:8366:9fb6 with SMTP id
 5a478bee46e88-30bc9cad446mr2408159eec.2.1781725374015; 
 Wed, 17 Jun 2026 12:42:54 -0700 (PDT)
X-Received: by 2002:a05:7301:10c5:b0:304:8366:9fb6 with SMTP id
 5a478bee46e88-30bc9cad446mr2408137eec.2.1781725373498; 
 Wed, 17 Jun 2026 12:42:53 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d0849sm26715737eec.7.2026.06.17.12.42.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 12:42:53 -0700 (PDT)
Message-ID: <dadc4a3c-19a2-4ad4-88c7-bc2554307414@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 12:42:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] add a note on -shim to direct kernel boot docs
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20260612161707.158029-1-kraxel@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260612161707.158029-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE5MCBTYWx0ZWRfXxBBQDqVc7mEl
 O3DXnMTsq+bCYM32FxyDGg1QgrMRBk6vOMPOX1B/rVoQwOEd9gOyiytmQOtIS8HyzHcshwa5nZx
 dXvEYBPbbGrhxN8cwGwJxSCi9dfSkTNDD8XdrVbvE7QWlE4PrVzIosj2shsL4emdhCfQejPn2g2
 bFSfSdM9JlbULPq3+sUYpO5dn3eTrh/9pyLQ1kNERsoFIP9zVGjpmicfuzc9TtuarbnDO/tC9yZ
 QXnaOj82vfjozzjR/J5GxMtb1K0cGvjJCG2ucfaVpID4qzHE2RiYKPEjPTughcYsjW8FmKigbdY
 VJhSoGfMzmPXnF5n3+wqFOBmt4vl+0ebYAwlR21OnR+eYDInVDJzIkOISNH41BlaStsZUNV1eUX
 wlZPXedJx4L5fzoCG9ZCzOwevgVXZli0ejHixp2mC4oL32JgHL7zvk9/fYDt2o2OvzYjlGMNWvD
 IadSbiZHKBTEpd/oXew==
X-Proofpoint-ORIG-GUID: a-4trYVfdgNpWvnlI3VNphn_DZE6x-KH
X-Authority-Analysis: v=2.4 cv=UrRT8ewB c=1 sm=1 tr=0 ts=6a32f8be cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=wLZQiVpf1cABdgcX:21 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=CiWi_AYZ1yyMSKtx66AA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: a-4trYVfdgNpWvnlI3VNphn_DZE6x-KH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE5MCBTYWx0ZWRfX97Wvfn7vOwLn
 mh7k+taRTqdUk87fKa/oboDlDpLxT+zMgPD9fjxKDwp9bE6GjTBsonN9TZNaOiwyC/0UM0ISQ/b
 U70yWxmmNWpScNYmwrymN0Sk9USac0o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170190
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

On 6/12/2026 9:17 AM, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  docs/system/linuxboot.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

This was merged into master (1d948f44240d51929f9051d997ea83e3213bdd18).
Thank you for your contribution!

Regards,
Pierrick

