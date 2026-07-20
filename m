Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE78C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlv3o-0001C8-3x; Mon, 20 Jul 2026 16:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlv3m-0001AB-RB
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:57:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlv3l-00005H-6O
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:57:58 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTSRh3492064
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:57:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q5m5YhLzsuHt+goJykgjATSDXmmGEZj6f/t2DG1fv54=; b=gypfM1C+hunrJKHP
 PjUplKokm19F9kwMHfHjJXb83UIG+z/+cXd0m7YHJBxAq59vkEL68OqFB/fwlPw8
 EjjzoRbSI253roi6ECXdNTBWjE0TdXujyVQlNmF9W2bjuzCkpUGPr8/n2ozUUBGG
 jWLnAA/2HqXOi92LTnGypSyHcb0bDgVjyNoZUSnvD/zzaHJA9geKQtDOMgXQrJCy
 qF9MEauOAmdkFQnsHOtNvZH6OU6+f/GN3wBQX63y4BFLSK2RTMAktpeE659hhxqN
 WLNt4QXyrJKDfU674Xj8cePSrBV1NyPWHk02iGk5+8Y0GwQxG2VwwvnXLJsJU+8I
 CP79Xw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv40xma-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 20:57:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-522de3c645dso66027381cf.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 13:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784581075; x=1785185875; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=q5m5YhLzsuHt+goJykgjATSDXmmGEZj6f/t2DG1fv54=;
 b=QFgrLa3hwYA6jCBytGpjqS+3m7xhDUEA4h1QF5GOfvXOVPRd0awZcvgdwaV3yJI2/h
 raSXXvorlt5vvuvyn9CvtNGSv8D+z20CwysXdwiSDxlcg5FI5CJYPUQALhij+xKZyEbm
 daENUN5VZeonEKjL9rZt2ZgTgm8aRZCS0IEh5RBcbSdw/WS6zFudyko9hD/j0Gfcgglk
 53KokqDDbx1ynSFQblY/QGIkuauEMFKigK7XkI+WSnuWqpOMiiskMNTWhgwgskwwD8ky
 1QM0MBBInEokiZTOxrzfnDWm3tlaJPUMlLD8YM8MQFJDff+OqKHHmoKPXBpmZD3/wOW5
 Ua+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784581075; x=1785185875;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q5m5YhLzsuHt+goJykgjATSDXmmGEZj6f/t2DG1fv54=;
 b=FZc5jU2tADL4MIRpgRAltGi9WaaP+2xoajsQKjn5CGusNH0xzabWYxGxdunmR4FBf0
 dzMXftBQQthfwkH0HKBidztrUo18j4pI+JyC4PN4O+pa6Lk4K8+++txnVU+51Uy+V5Z5
 26YJ478Gn3CYV0NkdFP/FlUfO0rfy3iGe0zD4BdNavZ5jaEM33YzDzIaLX7I1Mxl6cOV
 blM4Ug8Bb6yXusieW5FtAlxghJbInbXiSdZFZ7fWuYzki7fYwZy8j6j58Ewq7qZmbmTW
 FKs4rhrehr/YQa8IeOfbsU0u/I5lJoTMIK+qPwYW7WH9Rr/A2O1YuMmS1vHI62Y69eFG
 LJoQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKTzU0Fq5L79TNKqYSL3kvAQDGtQJAqEHyVirhtgbXalekYCOG8aR2QE4F0TNptGdIy1V55evWqixB@nongnu.org
X-Gm-Message-State: AOJu0YyTHN7Ejh0Ef9kjRjTyhQwAoxS/03SjC3HZNbkU2CcDvf+d21Av
 jIJ7AnA1KEkMOEYMBxTaCcsj51ZL6dhck7VStJP6MhdtqmYqFiYMLV9hrRIuCJ4gAKTGlzqFpiI
 DFlQWb2GJ4daIRja2LI0OWzMzIt1ev/I4Jw1l6ZBIe+Hn0ngyAucr7VS4IA==
X-Gm-Gg: AfdE7cm0kNSIfaH4vrx7D6cCxMViYEvENjfxovV8QlQ8FaoARqqyYRY2V7YO4GTynvg
 3H8njJXwGqB09mtsUtqNRX0wlhf+dt2n2EXD+75m47t7HJGC5E0DmKvs+a5U92yKK8npnjCWUOP
 EH6gyJ6kK76MECNricKbQs0dBLr6ZQXSyhwxFHUu+Hc4jS59lssbYJX8k7ebBaPqJU9LoXN9W5m
 EicZsAi8lmxO7mr5ix6Lw0sLvhn/sFPiYUfB00HrDQqO3Bd3pxDX55qtfFES+kdKQiUXEyKG2pA
 2u/ljI+Mn8/uaDK+IZm8M49P2DTUhQ8zUYfJ7gqIxWSbiQvyUwZiC0Qoxb8Ly7WO+n6R6rXDdPX
 2dpFrOOEqu0Yljj2PJ1UROIM8hsdvvmNnpGfFgcXmzi8juWvvh/Y=
X-Received: by 2002:ac8:7d4f:0:b0:51c:185b:29e0 with SMTP id
 d75a77b69052e-5213a3824d6mr151131251cf.10.1784581075122; 
 Mon, 20 Jul 2026 13:57:55 -0700 (PDT)
X-Received: by 2002:ac8:7d4f:0:b0:51c:185b:29e0 with SMTP id
 d75a77b69052e-5213a3824d6mr151130961cf.10.1784581074544; 
 Mon, 20 Jul 2026 13:57:54 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49548e075d4sm221781295e9.1.2026.07.20.13.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 13:57:53 -0700 (PDT)
Message-ID: <797f3cd6-5ca2-4cba-8aa0-43fa883f274c@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 22:57:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] qcow2: remove invalid qcow2_check_refcounts calls
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
 <20260720-co-v1-5-fabb4db3c204@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260720-co-v1-5-fabb4db3c204@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PXZtkxEnLEu3mVDAoQQhI8pMwzqfHBbo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyOSBTYWx0ZWRfXxutk4BmWUeqo
 blmDwqHVYQp6bZ2NoALl4PcU0rBQCAgT3yPiB/i1BS0g0WKqSyoJDptYkeim85jSGx5sRkacpCg
 9h4SjxV+1MEBriX5ks7K6uvOImlqea491B1umNg/6eV4joc2ysNKBxdr6uHaOiVoXyuRrf1PgvG
 6mPn1EhGFPHQxpkRwiLPHgJm7PfxF/WS0xnRkNTYyghdcsrc2t06ylqaOpTO3l8DeEcVGtihW1K
 BeGTf5f5vj/lISCbBWJQhYksrY2yuiYXGcop2pxBKuiJHU8HFPUU04DTfd/12PbEyvr8AS9DCF/
 6mMg9WgowjrAYwQAdbgmaktAuFaprt69CKmneqS30d1tMaSr/BZqcPA5iN8F6wVYmEMQzNkDi4/
 FUnj5MJRiLHZe2qjwx6U9bNT0rA4TaTwK/fMOj/3PbqEqaRYGMnqxlBjJJ+AbImE+SUBx2zFbzB
 8cvJWa7zFV/4a60BNfQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyOSBTYWx0ZWRfX6/wssqnm9CmV
 /dg1SVTVZCs3dsHavUe7MQvHxUG2z1rljIaUwv4Nl5iEHBfAUWnsjuc9DYzzvIcJ3A4RIWPomye
 1zpmvrbRZcqNFTgGWnZMNxBn260Tsa8=
X-Authority-Analysis: v=2.4 cv=daawG3Xe c=1 sm=1 tr=0 ts=6a5e8bd3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=bejFeoJku8wluUMwU-oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: PXZtkxEnLEu3mVDAoQQhI8pMwzqfHBbo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200229
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
> Those DEBUG_ALLOC-guarded are dead code incorrectly calling coroutine fn
> from non-coroutine. Remove it.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   block/qcow2-snapshot.c | 18 ------------------
>   1 file changed, 18 deletions(-)
> 
> diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
> index 1e8dc48be1c..8453ad73d10 100644
> --- a/block/qcow2-snapshot.c
> +++ b/block/qcow2-snapshot.c
> @@ -740,12 +740,6 @@ int qcow2_snapshot_create(BlockDriverState *bs, QEMUSnapshotInfo *sn_info)
>                             ROUND_UP(sn->vm_state_size, s->cluster_size),
>                             QCOW2_DISCARD_NEVER, false);
>   
> -#ifdef DEBUG_ALLOC
> -    {
> -      BdrvCheckResult result = {0};
> -      qcow2_check_refcounts(bs, &result, 0);
> -    }
> -#endif
>       return 0;
>   

Fixes: 70bacc44532 ("qcow2: mark more functions as coroutine_fns and 
GRAPH_RDLOCK")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

While here we could remove DEBUG_ALLOC:

-- >8 --
diff --git a/block/qcow2.h b/block/qcow2.h
index ce517040c47..5e1f916d58f 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -33,3 +33,2 @@

-//#define DEBUG_ALLOC
  //#define DEBUG_ALLOC2
diff --git a/block/qcow2.c b/block/qcow2.c
index 19271b10a49..6965b80af03 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1965,9 +1965,2 @@ qcow2_do_open(BlockDriverState *bs, QDict 
*options, int flags,

-#ifdef DEBUG_ALLOC
-    {
-        BdrvCheckResult result = {0};
-        qcow2_check_refcounts(bs, &result, 0);
-    }
-#endif
-
      qemu_co_queue_init(&s->thread_task_queue);
---

