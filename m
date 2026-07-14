Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667A7C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZhr-00013n-Jn; Tue, 14 Jul 2026 05:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZhl-0000zj-O4
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:45:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZhj-0002YB-LT
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:45:33 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6Sf4H3954888
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:45:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R2VQTAl4AhHhvlYlhgSkI5qb4PyNmSS/60sIqaYJwkM=; b=GxavGHsU6sffYkZX
 Nx1EYPuG73V6bvua1c9E/V2yYHjNxwLkHucjdfByyBkPjulFLvHImBgy9Th1yxkD
 8OwXVFq1zQluBd3la7vDxZFz84H9dYlRZcIesuKUb85bgL0uaVP9NL3WWDDgDPID
 tju6AKBlGAvpb7tyQTPG6zGxM68ZQbFUoeYqXHEPeUmeDBbCM4p5e+yMTyfh6zhv
 Xo0HYI9FjqRhx7OnqmwsGoMYXoZ+J+1g5YwIr/oi8ir1bdH6UPsyleXUauDmJdrd
 3VALk16WKOylVZ6c3v1b/L9KW2N2WZO4rOYG3ajYS8/xePm+FHjxxYAJ5iUFMJIf
 ONbpMA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44ju5hu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:45:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso80599201cf.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 02:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784022329; x=1784627129; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=R2VQTAl4AhHhvlYlhgSkI5qb4PyNmSS/60sIqaYJwkM=;
 b=atdkvhhoQnaMBfbxelweDnUeD4rB1NikOYBEyahCxFyYZwQRADPYnKz9vuFimW/1Dw
 2UsS12uoSiNs8PRzYEYYKdjd6VDn9RggsqXKRpXrtNTyYQOgm1AOVLnp9/icrRa1ynDa
 n4ybLGwk6lInA+xmGoML30d1qSe3MQ7+IS/WspDKlzPvBBMnvTuYQx80fyle4iIcWbEx
 ESGxb/RXxRg1pCMk1rdbfk1+DYdAR5QMrHiPtWnh6wMv8MHSf0d4QissLn+b+aazpFNG
 vzE2yg1ISywVdiMy2B6Xw3m4w5IyADJGwCzEYvZCRTJuasji3ildbbBU0xp12o1hUB5M
 57Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784022329; x=1784627129;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=R2VQTAl4AhHhvlYlhgSkI5qb4PyNmSS/60sIqaYJwkM=;
 b=beNHhR1P//Zph96B1yDJcW8z90woyZoUO09OY68vBmfj8d7vlY+NP4OXQjVcWN6K28
 W51avYH2iZiT0uuvjAG0LUl/kMxCTF+YDaRQkpflGbmjkPN3IKOk87vEHK26p/yOJ6Ga
 WUMcIiFDy5dbgu4c0fx61zjvD0ooR5sc0UmRex7tnaOTW482x0EMT/4t7xXNUcJfAIXg
 yaSMYLBq1MTsFr8In3/LBrBllpAhCXRkVsUpHt2l8U/LcXGyEtEVt2/yyDSHTgWekzjw
 68CvPtjxC0rjbbUCSFbXIPfwz9mOdUDFF0DzseQdIQnJKWipzVlJbI7ecDDZ6zliYjBQ
 wwrA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNTUSVxMsa9VP+dv8kM7Z0Bdz7UFoBAOOw2F/6RuMo2x2ZZ/HJxhUH69PFIqsHvJHzgmlIOk9Qwk+C@nongnu.org
X-Gm-Message-State: AOJu0YymDKsfHKvsAqlCMegrzMRQzDYvvlntNQLll4JWTAJoaCoXLR+g
 H+tvA867ruYOnWoiKzUExfJmfmxFtIRM6lbfPgpK6sD9E4cRqyE6RnfvcWAv5G3mbzxFrL55T9K
 5egWGVjeZTynO8DdqjflBYrpbsODVvrGY4Dyb0tD1DBWJdK+VG8pfydhL0g==
X-Gm-Gg: AfdE7cn52qqJimTLcYgyhVzdp4tsH4dqcZr8KvnUvlGDbRvRcZYEezCjgCuVqMli2Zq
 MLINpKRC5s2nrGbydXZRbPoK0xw4ieJAlsqpzqCZQIKbJ6C9jBfd+Pnn9jTZUvCEmSPQyeyY/JT
 rVc1MW5gp8D9nQNEbcn7VdJpwLTghHJN2cAG6QF876c9aqDajXVujfKrgKeUwbmU3A1iHBVJ6I+
 t3AHn9zg9bGpBT6U2o6x1Gi26z/W8Fc7tDx+QwDX9qvYJWzpDPv5Ym7ThzwrSAB6IQRKXndsslg
 rPuZ5CTHxGO2AxZgU+rs1n9znoI4f+rCqUHpJ1BHz31HTPhrz3ik/hh/trWudyC+F5HSx6ioVtG
 5GzoZCl8/4eXJyjX23maZZlazx++bYE5A6vi0Rp95qwkrqaaSyO4CEYXeHXB5BQ==
X-Received: by 2002:a05:622a:1147:b0:517:599d:ce19 with SMTP id
 d75a77b69052e-51cbf2405b3mr121248211cf.48.1784022329222; 
 Tue, 14 Jul 2026 02:45:29 -0700 (PDT)
X-Received: by 2002:a05:622a:1147:b0:517:599d:ce19 with SMTP id
 d75a77b69052e-51cbf2405b3mr121248041cf.48.1784022328852; 
 Tue, 14 Jul 2026 02:45:28 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15da821c58sm826693866b.48.2026.07.14.02.45.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 02:45:27 -0700 (PDT)
Message-ID: <2bd22d4f-201c-46bd-a2dc-38bcf5b4ef1a@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:45:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/qxl: fix TOCTOU in cursor chunk data_size
 handling
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260710134352.2313675-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710134352.2313675-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8gmamUqJz_iYQ9B_TIfx65mQ1tUJOAOp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwMSBTYWx0ZWRfX8Seakoe2RkFC
 YZBBqPWLpiCXB3QL2J98Mocn3GEMrtUQHBjJufz5C1S/ciNBoOOetOgL2g7AVf/cDa8myNlp3f6
 k1KC1kz/Kt3a3lNZ/eHhlYiPJkJNRkP3POG0H221WRrJ/tWiLa0tu66RAtWdSv2UdMAZFlHCSS3
 B9NXGAffsFLOJ2AuA1NWzfB+u+xndA7o9TODapmiQWQY2mi90LZZJYSaruu2Kt0qKklVBnKExJI
 Y2KBQZpkQLu/jU9GcNCNF/yANDBrG2mUQ8lQlrj2sYjo9fVR7gQCz68QLlx5uw/Csr1pl/n9/BU
 FVZ6sVjF9VALZ/Qa4IZozFR789w2DR36I1ztt3TEsZH8n/BZUVb7OkTm/pwMIQe5w0irss0zeQ2
 OwcfOQrpsx+ycZvmnOC2e2Aq46JdL8CoyBmDEiwTw2Bzwts4Raug4zKARmolqa74AfWSldn50wA
 JGhjiqToaZUxUt1f49A==
X-Authority-Analysis: v=2.4 cv=XonK/1F9 c=1 sm=1 tr=0 ts=6a560539 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 8gmamUqJz_iYQ9B_TIfx65mQ1tUJOAOp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwMSBTYWx0ZWRfX8YieiuDAu177
 rF5llUh2ekkU957FhZggzu7mVNt9YzyNM5uM3NtKzYBsOFTgAfc9DNJ71q0tLl9g38iVZTGR55d
 hZAVXkkEODEfFr3TZ5xPEqXknpUxdBw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140101
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/7/26 15:43, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Snapshot chunk.data_size into a host-local variable before passing it to
> qxl_phys2virt() for validation, and pass it through qxl_cursor() and
> qxl_unpack_chunks() so that no subsequent code re-reads the field.
> 
> Without this, a racing vCPU can inflate data_size between the
> qxl_phys2virt() validation and the memcpy in qxl_unpack_chunks(),
> causing a source read past the validated region. In practice the read
> stays within the guest's own VRAM mmap, so the impact is limited.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3757
> Reported-by: Feifan Qian <bea1e@proton.me>
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/qxl-render.c | 28 +++++++++++++++++-----------
>   1 file changed, 17 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

