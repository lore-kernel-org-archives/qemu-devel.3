Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F82606A328
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 01:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EeTHXIXB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gcPGZHKh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJLFI-0004Vn-Uk; Tue, 20 Oct 2026 21:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJLEp-0004Ga-R4
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 21:35:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJLEo-00039D-AE
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 21:35:31 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KKtk711716875
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ETfAmdJ6m0FkKDuAHOsVFHtEevHFgMkaNGwYd5vtPu4=; b=EeTHXIXBKnboAXqe
 7iLNaXltmMvlpKplk/nc5OvR4O/25AA38GEUJxOcrX2uXVOpDAsH/iL4j0TWCZBT
 bKom7MwxzqEZy+aIQJM6j7DRbqawV9AJsPbez4WEkELqU0kNlK+MhNXptrmcTabD
 P3g+YIPGNg1hMQXGpS72mCe+EAKGd05gfTqCHSTANIfrqynE610aV4cvPG7/ZVuB
 v9xlsZ1qUczyWneMpi1jTqo5tAMfl7tQXfL+Ody4PKEpKRzgBFBfCD8Zs24yHDh7
 g9vkVs4ly3ovCtyo+i38idUZaDKuhYb+OZ103ZxxikR6py3aZ+ww7ggBR5QloLWH
 qUAl5g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heeb99557-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 01:35:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f1e62510cso53969585a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 18:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792546523; x=1793151323; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ETfAmdJ6m0FkKDuAHOsVFHtEevHFgMkaNGwYd5vtPu4=;
 b=gcPGZHKhc9rX26d7zuf0D6fISk7MlWscUca+R4dIm1kMtvzXN4mZLAH01w1vsy2cGC
 JPo1rhyKfgQKRB91NuEQC2lKpsz4lgPofxtWFRVST/tLICbW3sAi5rXZFikQVIw4ocnM
 iZp6s9hexagtjKEVahCB0eP6XBvLM0/SvpOKm7YVlVjCYFTYPMao+A2mXxooyJPVuIFq
 505IupyDckgetattoCjl4iXH4ECv22xns2v3myZpNGuiJyheLrBsxRMR/orBO7b6D5fg
 E9htVWcakzzsDushrf5Z/jYaXl6fPqQpv20TkLA2fZd13jbcdAKL18Bpyyhj4MWzGvwH
 UJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792546523; x=1793151323;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ETfAmdJ6m0FkKDuAHOsVFHtEevHFgMkaNGwYd5vtPu4=;
 b=N3XKIjpaC4ZnVLczSrLkVD/zPPFHBJj9JvaJoB77tgVdRV1sljSK2QZcMAbyGplgG8
 L1hKCfVtd/SolxfF3roGZTSFDDBG9rlY5W1cxg+VlBuBMEc++xHCFZxWtRF48GcIxbYz
 FZWjsPySa2lITWu5dAeTgrhiV1+yuI+V1zqlgBLy369vprBcWTiATvAoU7dhuAHOlm93
 fEkSdbrGtWVBRVezeF6oJLnc+iHDzhYzNee0KfjkzlNa0E4QSGdWXBehy5P9Cp1PLyog
 2rS10MEj6/dhYrC3kQ8CkqNAUj8wLFSMIHtgAcjT6djkIoP1OjAQzctcrLsTCib1stn1
 iaCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUH7LzCUfKN0KjZ2XqmNTDRo5/7gDVX+kc0Ut9fGOJtAJaF58kOp2Kmo8dNPy30+SBIhsFafUd2cFM@nongnu.org
X-Gm-Message-State: AFq9FYK6RaaRbKSLICg57Zp7tK3Tv91fwUROgeOI1q2+U4bN2fDL982J
 +X0Y5ERjGVpotoG6ZYazxSLW4jNVb64Uo+k5r/u0nO9aZe8suwksCuIQLxE2QYv+YIVr6SrS0ku
 irAXgbC0JpVKM4xR2SYPOoTEIUuhub7/S/XshhKPzgOvYYXcfZa4ZRSoWJw==
X-Gm-Gg: AYBFou0r8vc4TBwYE3rrvJFQmi9KkRzYS681W2Neipw5OZGCbJC7FwJfCoZViFiTi9F
 3aJeLxCsNwRxEK1WnjEFiJKfonORYu7u82mQTET4W1vfhwqETx85P0JQ/QLnQk+czYRc58h8WvD
 IHwO76rxcAhUwFigL6zQ+f6WXvyc2HdeQDjumfqyAOctnrwXJgmy0LYI7Sx5GL8z5GOzq3xqAIK
 Z6f4XwtETV+gmKxnlv71kLJK8DEylYn6JuLYSpcgn83XyVRC7rnP4h3UYu831dnYCaocQWZXmCz
 Lg6RQ15lO+P7PIlpR11Jt84v8K0WFripirtXm7DtXnvzPkagWSZIXfjOgUY4qnmvmWdlEIJJAqt
 Ssj9OqGgKr03sE2jAacRWy62xhzWTff0Opg==
X-Received: by 2002:a05:620a:4543:b0:93e:6064:8996 with SMTP id
 af79cd13be357-93f57e66fd6mr199785085a.8.1792546522940; 
 Tue, 20 Oct 2026 18:35:22 -0700 (PDT)
X-Received: by 2002:a05:620a:4543:b0:93e:6064:8996 with SMTP id
 af79cd13be357-93f57e66fd6mr199783085a.8.1792546522511; 
 Tue, 20 Oct 2026 18:35:22 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2582a53fsm2126238f8f.32.2026.10.20.18.35.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 18:35:21 -0700 (PDT)
Message-ID: <e7cb60f3-469c-48bb-901b-50ef772d37c4@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 03:35:20 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/21] dump/dump: do not dump machine if doing
 heterogeneous emulation
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
 <20261019212648.154493-3-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261019212648.154493-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwNiBTYWx0ZWRfXxVLlrRD+lOha
 XLkEQAl5m5Q0llB0QAFSZX5D+LyIhR/lGIuu/FlxGYU28UrZkUoLIgyoO1yO3in7KqAXu5xitjS
 aWHjmuFrFA4x0w4l9gyjc1a0A8HMetc=
X-Proofpoint-GUID: 63aoANyrVRMvtNI-eQqgnVa4mTmiPvTj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwNiBTYWx0ZWRfX5Tl/vifZowUJ
 7NB43AfBPf1I9hBQOr1EEa2+B/D0Iw8hCZ+56kyjaBvd9vivLY7ED6WS0DJDxZVhQovEw+8QPlr
 ngeoCoBuZCW2AwEpA8eWypvVPo5gY0TSsahCO0Rew4lJyJnwxoxq1BJZ2wvQE0mKtPN9QFLRTGk
 gqMpMidIYwGDWox6egO0izD4nhFvY3jt0/kW1dKz9D5487TGB+GVIJ4mpN/9slZAaD5E1sarFap
 iAYan9uUUpemJ+UnV8yQn864rWWOvt8Q/jcI6WgDgEYLyObhmqzfLMI6d8d67lc2/aLyp1iWWiU
 9+bhg+kJREZ699CT6iTrRvGRIqHzE5RXA/bE00biEu3TXCvb+X7v+tLH75FChtLgSLvEhOrdJ1S
 V7CM3s/Xs7gUDzpoI9Oe9CQ+SKGYyk0b1n8h8GkuzB8tTnkMSvhfUY6Ivr4yRx0GDcSetmF5tuM
 eF3dVvViT7i1DGi1sDA==
X-Authority-Analysis: v=2.4 cv=R42WitRX c=1 sm=1 tr=0 ts=6ad816db cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=DQOEYHEwb3fDfsLQuBIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: 63aoANyrVRMvtNI-eQqgnVa4mTmiPvTj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210006
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

On 19/10/26 23:26, Pierrick Bouvier wrote:
> This would need some refactoring to do it correctly over all targets
> involved. For now, simply prevent this from happening.
> 
> We do the check at beginning of function, so no need to call cleanup
> routine.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   dump/dump.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


