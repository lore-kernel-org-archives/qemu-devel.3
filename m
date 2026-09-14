Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 836CEC88E73
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 20:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Cr0-0000vI-C9; Mon, 14 Sep 2026 16:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6Cqq-0000qj-TI
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 16:00:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x6Cqn-0002Xc-EO
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 16:00:27 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYaHl1383326
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 20:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hzX+SFovEMulllksEz1sle7/JMcgwcVMroR3RAS57dE=; b=d3qEJyn1s2WPqEp+
 I2ahQgjBogm+I4eQ7bgenaHiMLeEMdTc2O4ejLl2REv9eJ/dyM5BqWwCcZFp8s8H
 UaM+gy3B9knT71o1FDA1wZsUQLkOcAfDCOo7OgfFemm8/UBjK8udRJRNSn0nbris
 g6JmXpreF3hVLrqlj5s8meNjwKHt8Wjn4jhFwqE8MQxlRxO2pGuCJ59h2uFNhLJD
 N5bTi1xJy9qB2farDYYu6k2RlJH7OaFYIEg2cl5sBM6vGWSmYO58lHgUQyZVKi7A
 QTkFijf4yYjEyD0pB8L00u+bUf8M7Farh/FcKtL5mICZSHYaQscV151X4BPYdMq8
 zTFp8w==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpgvthwdn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 20:00:19 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7f4e8568ccdso6008420a34.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 13:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789416019; cv=none;
 d=google.com; s=arc-20260327;
 b=odVQza1u1v5Io/yIF4Qfp5pfVmARnN6n2pbsT4+ZoVxopwVhkM1xnZDNYJaFt7DijJ
 Dc8Bl9ckV1zsHS5HmAJFB4HxH5JZfNjs6VvoDwGQnrtF3UiYGXGVOpms0/kNhF7880Ic
 s2UVrMPIye/53TrY3z5J0aOTVKwoYnqFDrjQRBspIWpXt7tb9jDuRotckczXMbIu+SzS
 VZwpQewKB1bNuIzmVq1S/oj3iEmK2DjRIn20+qG2TRkwFoJFKAN5NOQYQfPJCbe50fap
 pKGTU+9pjSBg5FknrtNroZ+Gco4W6pOtRJlj/cvZYsjm8VR3WCE7yrxX4VZ2HNhQlZDO
 8y4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hzX+SFovEMulllksEz1sle7/JMcgwcVMroR3RAS57dE=;
 fh=OSkAXfMXEjEHEK9eR4/7X1OkKzMaRPS7D6WMhg2fqKg=;
 b=E/JJaZ9zhS1iywDbmMShXE0i+fr0SpRt17zFuvPPLcNa4Vr1vZRmQZBxQs9r/tHVvl
 /2/B7zRCetrRlyeKjAr/jbV2K+5Nu/Ps1GfFQpUloO7JeqJA2BkZmltfT5msD1XqrYAB
 2jhXuOCRKDhR2KDs/aMAVnf1fenGw6bgkyUdbYrTQX476Jk+uvf5g4uVZSSInQDx6R7B
 aykXHAf4NcCqCziBsc7pZwgwAYZBmyfzigJC2+wG4jFdDKUZNEteOkzbjAaqLv9kZRwU
 aRSTps46T2fPx4zWUGHsJua+BweohhQ4yPvAF5GloGN38t3LbXpQ6f/zcKMvuLlUvFR+
 e66w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789416019; x=1790020819; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hzX+SFovEMulllksEz1sle7/JMcgwcVMroR3RAS57dE=;
 b=TvFr/E5+X9YlJn1tt8TZMM8beKm+S97VIaQxzPqrUS9soUDe2hO2GDP6ormNRui1lD
 cTBNPD7X7kOCnaJwPcIl3UGPSDwQP6ReaEmq8GOGw7CXISarLaVJJo8LlQ+FrgkQYgr/
 MEIwUzMc8c/8leudvtRO6Ae9y9S/vXGS56ZFSy0NEwrESLJL9ZE/i39Re+yrGV2dYylU
 6Tcb8aGYUnmkMek+foFNZscRG3/YkskpneMpGjsjS4dyyLEcIelHf8blXd4DrRDnn0MG
 kQsuLMpuGN+sCN7Jb7/i6KLzVcRpngUF9x9Zj5R7P+sx/iYY7pAeqeqjO4t6veaXn+Vh
 A6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789416019; x=1790020819;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hzX+SFovEMulllksEz1sle7/JMcgwcVMroR3RAS57dE=;
 b=WzUjzY59ej/9DPamgBqZHgtjSoAb08WT/6UfddTLyYxhosHpYdXJobGBFyv6fs4JbM
 XG4+KEiomYT0UbMzXEazYfx5mwum0GmXxCbifBLlzlVyzHWcwxZG1T8jSBh1qKluktpJ
 jhKjOm2HuvrxO/q/M6mgUXUqB6zw5wqu0k4oNywNsvwEyd4jipygQJpEq0UtW9/YwMov
 IHl7/TY6XBhy1FItPO1AEzoHjKWSkKAo8Jt4xirOV0dfUyOurWumeTdpbYuCZRpwlch2
 du1SK8oP9tboLUAeok/LYbqghAzwV0PqIJ1bubDegJAgmKOwpbPaQ4vvQj+Md4B+URS1
 vVaQ==
X-Gm-Message-State: AFuF++ksDWXBsG0zxPtwT1T3dJjzVXNzoV9k7hUO8lhg6WNMWx5CfS4v
 zqiNNBJbthmB7SFO3ngSrBqio/KAvOL2t309DhMYbZeiHzE9PHFc9h5/8HAa9SdQriWfRnh0eth
 M3a48cGqDVBLu4/z2K37502hNjzuGAw8AnhIDFwDqefjYHb3wtVCdMlPh8P38xFudKHCFolFSVB
 RaaZIZkyh+mFKMmJAQVwXNR80v2bNj0c0Q
X-Gm-Gg: AYBFou0uQ3EGTmd2UiH26qHxouKAQG5lZa9mnddFVv5qrKBqAp+LQS3Llwvsvl6U761
 wy0t55isOhSWNAY6DmjJoCcd6X9sj3k7V5eDHuBs0i60NzAkuZe9bcghMDU/kznBIKSVH6Gq1KT
 g8H8GcvoA92YkLfoxG3dyknzXOQgu4t1DsxbarBYY0n/Lrzccqoxv5/lUjOINzckJoHEe75+DSq
 sO+MESiHtGS7XKtng==
X-Received: by 2002:a05:6820:1988:b0:6b3:558f:706c with SMTP id
 006d021491bc7-6c542b35ffdmr2622050eaf.30.1789416019053; 
 Mon, 14 Sep 2026 13:00:19 -0700 (PDT)
X-Received: by 2002:a05:6820:1988:b0:6b3:558f:706c with SMTP id
 006d021491bc7-6c542b35ffdmr2622023eaf.30.1789416018552; Mon, 14 Sep 2026
 13:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260911220825.143115-1-ltaylorsimpson@gmail.com>
 <20260911220825.143115-10-ltaylorsimpson@gmail.com>
In-Reply-To: <20260911220825.143115-10-ltaylorsimpson@gmail.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 15:00:07 -0500
X-Gm-Features: AcwNN1WF4b-SNLIC5v03tYh-Wj94a33FgjSr0_MGosMuSQva2xHNXo53HyQp8-M
Message-ID: <CAJ+KCYNu_Ba5OdvmRMfcNkHY-jO2pxSkD+EVHe=DyOm-6CrzAA@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] Hexagon (target/hexagon) Check for sreg
 multiwrite in analyze_packet
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com,
 matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=c/0+0h9l c=1 sm=1 tr=0 ts=6aa85253 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8 a=zHKpWwpir6opLkOCUpUA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDI4NSBTYWx0ZWRfXxaSHjA5Ds1c+
 D25hw4FidpFcbfMMST3zMK/7mN+SkgxA2CFSYXYp2Pm2wwqVOoMIrJNlar39qvImpr1H7Jp9riD
 u+6UBybu6Ay1fqqatzY9c/Oq93gcfvRB5Cscf2ijc6zpA5BMyIjU79KQxC99rKELwHQKALsqsYj
 NhrNsYVYLCSGwCRNa3BXCWR3OvyPN3rqVR6JOr6t5OlqVWtz+HeNGc5Eal0NtHbslXi4K/VzdMl
 500MBZjZN6/ggc/O9C0V1xgfPduk69To48c9MljDhtokwO71shrUBmX0hsSvcSUo3HzA8BhkBrp
 VNtqCsmiErPM9oQf+GkuwILFqUBAX+7OAlbcvxWySPwNdUJYlmbYNq6xI21cQv3lTL7zVhGR0TQ
 qugYvzV02noX4OeA1vxbtJp+/YddDQft4Jxqz9YXZWbG3cmzhw52/2/jUXFbCMmrCigEwduPYVS
 CddLXZWLZhCEnIuh7nQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDI4NSBTYWx0ZWRfXx4XAxJ3MkHb4
 TAOmbd/yQY+nMRaEgZ+REQpzGCHsZfyZf8DF5dr1OMyXAbCxYaQXLZnTh41SVwRg5WBGmoBT7xI
 zHXGiKoBFQ3Ij2PLt9kuGNrvhoM6kAo=
X-Proofpoint-ORIG-GUID: FkSOsekTr4AfhqhzBM8s-CDwsKBrqHsb
X-Proofpoint-GUID: FkSOsekTr4AfhqhzBM8s-CDwsKBrqHsb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140285
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

On Fri, Sep 11, 2026 at 5:08=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  target/hexagon/translate.h | 11 +++++++++--
>  target/hexagon/translate.c |  4 ++++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index eb0d10d686..b90f7fff1c 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -51,6 +51,8 @@ typedef struct DisasContext {
>      DECLARE_BITMAP(gregs_multi_write, NUM_GREGS);
>      int sreg_log[SREG_WRITES_MAX];
>      int sreg_log_idx;
> +    DECLARE_BITMAP(sregs_written, NUM_SREGS);
> +    DECLARE_BITMAP(sregs_multi_write, NUM_SREGS);

Do `sregs_written` and `sregs_multi_write` need to be cleared in
`clear_pkt_ctx` like the other bitmaps?

