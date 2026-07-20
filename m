Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEBDEC4452B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wloy6-0000KO-6i; Mon, 20 Jul 2026 10:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wloy2-0000Iz-TY
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:27:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wloy0-0001zj-OA
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:27:38 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KDrGg02807753
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 14:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DWJNyilWcUWmfqywoqzffl/7oB98sIt3grJe2Xwyo4U=; b=DpI0U26qEQcoXKxP
 TtGYGlh1I+7pQIlnf92gRatiIy3HZN0GjVv5OXBwYy5B3nXwPY6m4C46K/K1gr82
 ThpIUl35qfqSyDFvzwkEB1lX0Tv0C5nlOhjjoWgmdM7e9eNhW1F0KEaao183S7Zg
 dkxN5ZC4g1Pjb7XcOhXWz0KemLT32T0OCTJ2WSQ1cNp2ANZ2w2oyHRgiaXHkNaw9
 IjGRlwUdo7PZB9xhgUfv1KQlzN3MRKee9Ez+KtL34KLX8TDDCeDZp1LZLt4k1zY2
 uLFKAaMMuazFJEfZzo+ASidycvCrtxeJVlXKiaQkhkV3mJR/UEOnBbk6N4T5ix7b
 AcPEAg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhgre9cn8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 14:27:34 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-522de3c645dso56634311cf.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784557654; x=1785162454; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DWJNyilWcUWmfqywoqzffl/7oB98sIt3grJe2Xwyo4U=;
 b=Tvg0mFDbyIxJPu8Q9HhZo8DGUMQmzLCHP3CE8tXd9YhygxcU+MpU6MOnxecFy/aLkc
 d2cfOWg+8jaLsUuuncNg/1drXviGhD0GGiQyjdm/A1Ws2Sii3Ol9hPkDyw9HUt7S6mb1
 FWZ0l+hfrj6KzlrisIOK/3+Xs28X3iUfX2xYPdjP2JX8mTxpWprlcVtqX6xBoWtsitfD
 dFU0l8Y/GryFFb56IuA1fwBBd8SMhvr9kPtxIaGYHBybRFATNhBCu2TRWoFVzLXOjOb1
 9sS2Cgyf/cbCZGYKlmpBXw2UuZ6vKoquQBQXlXIqSkspE32KphR+W9VmGUHbBLqeL0ql
 qF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784557654; x=1785162454;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DWJNyilWcUWmfqywoqzffl/7oB98sIt3grJe2Xwyo4U=;
 b=InuIfMi38IFpBNypjsVXgPAIv5xcT78s7xUrr3CJtP8if1Mp5ysBeq7Un99MFFjNv7
 KOQ5PU7h944aIqlFE7K2MoHA652UwwuqY/PbmvebX26kCeOJQoGdZ6nJITKuv5G3gnAL
 56ze1MvAIgOUJ3PBUzYU8acHh90Ht9S/AhHMP6OmZk0KvG+thuKKxsZdm8inHDSMdkVi
 wmbxQyw/VSc2RuGQmcnkMDx32++2ZfTbSCKN+kyuc8y4G7g1AwF/juxJgRwNvNdc0djj
 U+F4es/ftgYJ0jaUSkfsVTcW5nIrbY5ugA5/d3g1iwAIG75o0e4GW8hPBA5J2GsObeGg
 uVnQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDcQj1dRPp3OlvM1YBXYkT7KYW+97QcWdukGHxdAJ8VVqqyAyXZRXlsz0jIgpBKVmSDedZDSuRCi0o@nongnu.org
X-Gm-Message-State: AOJu0YxLxyvchFL5iX8FFPFtwceb5oWzAkXsP8BxyCqbjTEIJ93yaY3r
 N9a3jev+ZTj1T8/+ZN65CJnJEXww7qX8UCj/0a22WbZLKgkXLMI4iod//CvM35M5aOKB+EFE6/a
 BS3jKgGuHj2lVQwbTt+Z9GQsQnipFqNlded+HezixABlcZyo5Nhgoq4K0EA==
X-Gm-Gg: AfdE7cl6GxyOeyGzmRGKQDN6Gcw/JEXMxXZGwbhXuzaXh+emY7FusFU53pw9NDUMYtM
 J5olZD5DzjJXPuZc+mhe8IF39TYJrbVwbs9x+M3MV8C44AHqqJ6MwMvUmNX08JnoHb3ThqvyY2M
 zb2BAib9aO3U7mtWwy7h1KIVDbk78UPLTSQWx+fhkSt4cWYBqmUGANVLf/vk7PcELzcr/GCSJ0y
 duXspi++OKKlPQ3yTwyWEeoW5mwdohNJdmy5kNdDg8Bc/LkzjmRucqBoZfqvV0a43ZwKhue0CNU
 Ft97D/UVhcK7UadzFykbHFTMt7EYVKRUTl/c+p/40qBjItLC8HBhVz62LgkobiF3pT5pEP54Os3
 eilSX+RMhXbIk+44AhNfKqEiOrEq8QlJxBf9C3C7iaHfyIsl8wSg=
X-Received: by 2002:a05:622a:1a9f:b0:51c:a70:5ed with SMTP id
 d75a77b69052e-5213ad60752mr132018321cf.30.1784557654064; 
 Mon, 20 Jul 2026 07:27:34 -0700 (PDT)
X-Received: by 2002:a05:622a:1a9f:b0:51c:a70:5ed with SMTP id
 d75a77b69052e-5213ad60752mr132017971cf.30.1784557653592; 
 Mon, 20 Jul 2026 07:27:33 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ee0086sm32882765f8f.30.2026.07.20.07.27.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 07:27:32 -0700 (PDT)
Message-ID: <b160d306-cd5a-40e1-9c57-858a249e13df@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:27:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] migration: fix qemu_get_counted_string annotation
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Denis V. Lunev" <den@openvz.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
 <20260720-co-v1-2-fabb4db3c204@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260720-co-v1-2-fabb4db3c204@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE2MSBTYWx0ZWRfX0gi5DsJhgnLe
 SfxblLqd70Lf7h2t1V09lS2TNiUFkN5o67E7hisibI8h3k5gDw5UQ+oH+AAG1MIAnDzOLRToUb1
 S5F/kQ1lAyiMPS6+mJmN+aYK/k+kLg4=
X-Proofpoint-GUID: -uMdB05fm6gWDjDFvlx2LEyB89-AQfCp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE2MSBTYWx0ZWRfX/a1Bk733OQme
 3Z0d25cRi12kGqIaT+vHjVLlfIccof3nDZUcyn0RwR917EdKtT7N490cC8Tzn0m5E1N9mAfhksh
 lN6cMOXkZkeZAkCM3xElid0VBr043EzJJX6kesySOFtO5L8I3rIRbv5zBkmPAJzp8DoTDCSZ3tW
 YFOZz08yivb3Jw4dHOfczxdVLUcmnPLw6Avyriyvc5JgadfytEOmpU+UEs2w8SlK8x8BsJJyRvK
 1Fr/yHVS/r1AQCPteid+fZliXw77UikNgYYeSFql9DUBs2vUUPzBPHJDQfso0A1hcDIkYm7vWQH
 pHgB4U+qG9ooWFJYYJqeg+Dfz7oHfKa817mQFBakzAsI+VgvgWg3T6KiJUZBZ3RANs+llwP3Vh9
 h/ohC08UJ23yYALG9E87GkcShUbIyc47o53elLbDtuyPaI9GtdxnhiBQ8YnuB9a17Kph/Be+zLF
 eEANBtDy2qoyxdr8/Ig==
X-Proofpoint-ORIG-GUID: -uMdB05fm6gWDjDFvlx2LEyB89-AQfCp
X-Authority-Analysis: v=2.4 cv=foLsol4f c=1 sm=1 tr=0 ts=6a5e3056 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200161
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

On 20/7/26 09:55, Marc-AndrÃ© Lureau wrote:
> Fixes: 394b9407e4c ("migration: mark mixed functions that can suspend")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   migration/qemu-file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

