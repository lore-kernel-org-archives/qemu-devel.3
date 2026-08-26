Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30041C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzBFq-00037Y-2O; Wed, 26 Aug 2026 06:53:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzBFo-000375-J7
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:53:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzBFm-0003ej-VG
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 06:53:12 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QAGdQG630882
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JGF1mKMkt552WtF4eAslVoLboUzWc8SOsgIj2uWNIhc=; b=Rynb05M31uF3lKHi
 Ni/zvKkD1O6G6CdwO5ZWG2ZEz7IaXhHcIttfUlUYuPab7VphGTLpEDkrhUdtzS7c
 HZpdvBYuPp0/DePjRLjJNVn9UHo1LL2C5hC7hw26CQlFUpfoULa1wQt3xK6+7EUr
 s7xca4jU0gXjaFaUC7cQ1aXyrKUZYLwOSRMXk2gVTywJHlnXnLRtcmb8kd/yQwJP
 RcEsaMmEmKLez89B8UoZo4g0VvldemFLbuMn0m2oG1BiRQkPCwsH5MoppWDJ2exH
 6od/p3OGUPF5yBR+x8zyjaeg0xztOv2A1KLwRJTaiIuEqkgFYw51ivHfPefsOlTv
 xxBT1w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r0k1r4m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:53:08 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5174a236220so7483341cf.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 03:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787741588; x=1788346388; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JGF1mKMkt552WtF4eAslVoLboUzWc8SOsgIj2uWNIhc=;
 b=DEtbs2lpEbK9to1tml12v/Sp2dpgNcXhxZlhqS+9fV250aQS/4ZhlzGC5I7u1Z87sT
 RtcGeBqzP+FRgOLZwJsx6tyhzcgtkcQO3rPsc1hSUDV15hmpWHv8iQo+dSgLZADHDA3O
 s/fNHCTgHo7JXyf84qzjlTaZz4t21gWAjnCAl2KoS+H2n4/gOJyzJDO7Jy3I6klm5ClK
 laQ6aNf2Q1OLQjbL//oi2cnZc794wzB/t8A+XqgdLE2p/6VUd6IC1QfVrt1ltKMK91R2
 5rmGMLbxQixWfXCyYoOMnLO1O3d0CobCpsdjiZvKLSxNi0yRLjmTDYCjnMvJ/g/Q38NG
 zdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787741588; x=1788346388;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JGF1mKMkt552WtF4eAslVoLboUzWc8SOsgIj2uWNIhc=;
 b=KLqGehSKh0owPbJ3JlsG/Nz0iFefasJk2otnOLwh2AoWEt9K32VIJOd+P42G9qgkS5
 n/f8ZFbGDznAI8aFWu50bfMmdmnrEmP/hxMo5T9nDBxfy1EUXyEqltQGpZKJXH8ZR27A
 O9qDVzjWrGS8vvLMP+38x5zxvXCK8ifriykaJHVoDnlzPKC6HTVRlvSmUNPZ+mn4OuUs
 8FbocbWBRw+F9+cqm5RHzU9k4R54W8wj4s+nnBOKhPENXJUk4O8Ubfxc35dmP84RdiKB
 kAdAX/PPlJMrkxcWnuaTB5cLC6Y0ui+SdCFGY4D2T77M8KJmFZ47Y8ktYQVwjNeI5QGA
 U9rg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rop4iLlydHVvcbAWK4GRE8/2WSxSpl+6qgBMG7U2mQPBmKb4AuQ1nNactYkDcPJ6XdOAa65R+h26d0u@nongnu.org
X-Gm-Message-State: AFuF++kAhX3GVzPB9XEl8nGsmFVXhiBzOtVv8wAMQ1vP4cA8h7uuAd5K
 5V8ktXugayq3kTG815emkltpUw8xe9sP5vWy361EkjjOgFABaRrVNDRB7O0fqEP7TvMMnoVhlYQ
 h4CLQ7c9o5RU2VLdVnJsJqWlUn4r5oHrfO/GyxMLG46gzQPnec7Z67iV0TY6YAptKQg==
X-Gm-Gg: AR+sD12NprEU/hZTzu0rtqUVNLv/xhpOB4Jw91SnEiXEeakSn490S/Zx5bAlwGvGh5U
 rRCbheuu1U0CGvvJuFtmdgKB3Kw/1ZzUm8uYzUzD/N+o4ejcujv3zRgGGkBUsymhcKflaec7LeE
 AIl1dTJQgXGhllv8dGJ5EmOUZbkAj99o90r9kQqrATUonlDWz1kOnTFj5n1LWc3ytdpZ0HdL+KG
 whDEEtEYjdEnR/20IK5bX/wfyNvChjCl+8lLAVgu9U1hrbQbA436DeVJawIkZ5yLQDOWZoSJfqX
 kry/zOETaHth340J03x+o3fkQNpVnRs9B/RQnrYvTc97Lp9dz5HPgwbl2t4UU7xcN8l8S6QJlfT
 lKsl1lhuvleOEPbK/i3BGj5lXFJe0jNcjOWkAvG6akFn8Fw==
X-Received: by 2002:a05:622a:1b11:b0:52e:2e04:44f2 with SMTP id
 d75a77b69052e-52e4230bf1bmr55489891cf.20.1787741587772; 
 Wed, 26 Aug 2026 03:53:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1b11:b0:52e:2e04:44f2 with SMTP id
 d75a77b69052e-52e4230bf1bmr55489541cf.20.1787741587271; 
 Wed, 26 Aug 2026 03:53:07 -0700 (PDT)
Received: from [10.254.188.74] (31.18.205.77.rev.sfr.net. [77.205.18.31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dc96bff9sm23098945e9.5.2026.08.26.03.53.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 03:53:05 -0700 (PDT)
Message-ID: <5eceff75-8c15-45d4-9b16-25015a24e86d@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 12:53:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] block: notify the parent when a replaced child has a
 different size
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
References: <20260812121500.1034178-1-den@openvz.org>
 <20260812121500.1034178-2-den@openvz.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812121500.1034178-2-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fPEJG5ae c=1 sm=1 tr=0 ts=6a8ec594 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=3lFKFk2zyOZBiYL4tutsoA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=6rqHouBjAAAA:8 a=EUspDBNiAAAA:8 a=3fW5wxpIv8osULsFfy0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA5MCBTYWx0ZWRfX9Iqr5O83OyOE
 8L25IagT/9CUnbfWYrXeRvW9peN8giHhCDd98Igrv9f7ZI/aS04dX5hsr8rV+HXjVRB3l9QYWeW
 lGY/SlHW1wOCDygS1CyWyNeadV4Ev4I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA5MCBTYWx0ZWRfX4LqqlcoxN2SQ
 3HQO+9jXYM3KVd5xb1sqMo2dJZLEvCQPulQ8CqQK1y4P0jVtTHqLbI7tfOmsPpNq8KWPUn7LggO
 ZtUV1caDRe5tXKWrzggya7VsPhD6wq4k/7m16jdV+GvmRJDee09rUhLK9TSCWt55EvhWxZjWRo9
 UFqy1qGNWodMKPWslQULqxo5GmETvVBv72m9+3Gl5QXDscNVNLp1QkbJsVc+S5CPFLW6JMh/JSq
 PejwNVwrwcz6u+gVLoKTKp7zDJLsv6GH6BCjWWHfrFn6UcJ9v043irTm/BqZ+WAd4bGttO2G65+
 hFQ2PhvlpXwtDreGIUm3CPVcvsL0Hc82npE5GcTbglImGEX2DkbHwoEH/tQEWXx/bzyemmPbe3t
 K8fOTeKd/AlGl1jqddVThjLzyylugDpeWxrA1GOV/5fmcMpuuuamchQ6Q46OxryYnGDtq7aJ+jW
 +vZQ1Ln1W0hyGxPgTng==
X-Proofpoint-ORIG-GUID: ZXMRNp_KOI-ykAIO2osEVymp-cOa4H7N
X-Proofpoint-GUID: ZXMRNp_KOI-ykAIO2osEVymp-cOa4H7N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260090
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/8/26 14:14, Denis V. Lunev wrote:
> bdrv_replace_child_bs() swaps the node a BdrvChild points to without
> telling the parent anything about it, so a parent which tracks the size of
> its child never learns that it changed. Every other way the size of a node
> changes goes through bdrv_co_truncate(), which does notify.
> 
> The device models which care all register the same BlockDevOps hook:
> 
>    virtio-blk  resize_cb = virtio_blk_resize(), ending up in
>                virtio_notify_config()
>    ide/ahci    resize_cb = ide_resize_cb(), refreshing the cached size
>                and the IDENTIFY data
>    scsi-disk   resize_cb = scsi_disk_resize_cb(), reporting
>                CAPACITY DATA HAS CHANGED
>    xen-block   resize_cb = xen_block_resize_cb()
> 
> Only scsi-disk is really hurt by the missing notification, because it is
> the one which validates guest requests against a cached size.
> virtio_blk_sect_range_ok() and ide_sect_range_ok() both call
> blk_get_geometry() for every request, so a missing notification leaves
> those guests with a stale idea of the size but never refuses I/O which the
> node underneath can serve. check_lba_range() compares against
> SCSIDevice.max_lba, filled in by scsi_disk_reset() and updated only by the
> READ CAPACITY(10) and (16) handlers, so with nothing to make the guest
> re-read the capacity every request past the end of the old node is refused
> for the whole life of the device.
> 
> This is reachable with qom-set of the 'drive' property, which is allowed
> on a realized device, and it is silent on the host: out-of-range requests
> are answered by scsi_check_condition() and never reach
> scsi_handle_rw_error(), so there is no BLOCK_IO_ERROR event and io-status
> stays 'ok'. The guest sees ILLEGAL REQUEST / LOGICAL BLOCK ADDRESS OUT OF
> RANGE, which Linux turns into EREMOTEIO for reads as well as writes.
> 
> Emit the notification from bdrv_replace_child_bs(), so that every device
> model gets it through the path it already implements rather than any of
> them being special cased. Send it only when the size really changed, which
> keeps the callback out of the common case of a replacement by an equally
> sized node.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block.c                      | 13 +++++++++++++
>   include/block/block_int-io.h |  3 +++
>   2 files changed, 16 insertions(+)

To the best of my block/ understanding:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

