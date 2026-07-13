Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C904C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 07:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjAmc-0008VZ-D4; Mon, 13 Jul 2026 03:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjAl3-0008MF-N9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:07:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjAku-0006Un-BF
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 03:07:14 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D6Ngk2731647
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 07:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /NAXw4SWVtpZNUx2tZvfkbDmczAPcQ4V2xROZntPmHk=; b=l4+CXo1FilIj4lIo
 nEWU1gDU/znkKxI+zJkDE4brTYqTxlPjsPX7L6gjOAvv7aur4BudKoz5tvuG1GM3
 wCBwm7gtK+vQYCGsBwEogNRPaPrdwmVXS8RU3ZyPKIeeqN6Cslv9LvWXiqwYECKn
 u4TKAj94uPfNToVvngEUcOARkpKPM72yXAdiTNF3m9J5sTr8LJh97EC11Lxox4R1
 RSO+idKOfh+i1yiNMhuYjbhjVnWjgWmEqsyCm3neLAKR9qmAKnhvHalZYdXkFQ2G
 G0b+Us5uPgfXsNGGZN73faS61pMiNhV0vhhhugCRERJfapM5WNeMkm51z8dq/d3S
 G2l5Lw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjn39aeq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 07:07:02 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1b4d961dso26719511cf.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 00:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783926422; x=1784531222; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/NAXw4SWVtpZNUx2tZvfkbDmczAPcQ4V2xROZntPmHk=;
 b=YMxaYJ4DuQ/eknmsq+bMLjKO9yYryrCQKiUy0IbtKY7qU0v0hkV+0oRH+EUkUtq5TF
 MYvsi/U2GnlAy0RkJXWNJhB5DRkHz7eYvoWvO57QG6XwPGGPvDGZjCWeigRSqpds4EQJ
 J9zf7z2OtQvMO+LvXOT2PTd6M6Qw4VHq5UJ7UvrUddtIS/4jI4sDHtPTzlna3+RYd9Uv
 5368N8AUGbQuObl+OyB0+kByaiaXZbiCmVIvk4Bs7aMkvhg7FUWipR+KMKoDEKmK+8Bs
 00oAwzLzEU3oFFOQekT+g+3Vx4FvdS4eK55JmtCgKcO2pE46PfTRs04vVU+UD5exZ2tZ
 bAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783926422; x=1784531222;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/NAXw4SWVtpZNUx2tZvfkbDmczAPcQ4V2xROZntPmHk=;
 b=gHwyDSnuAIywLX/fIg14siQB5Og87ZpA/tFlJJDBESo3GJXo+n4qUqROwxFczHsF3M
 wD7q7YZtre7+LxrHJQjFOZY29Tz1NuyEfNbyXWwe3WPRWsHqFONaZm9aajcNpa0IboNr
 sKyzPlmwYXvlyG2VWcNkT+uyFUhRgz/4rB9Lz3uZeN6+ci6nLW3zKGNRJQwToMNMuItO
 L4DzaF9JFncKX6anl6KqP7XIMrkoN10z8FubbnowfZnqoO6vJpdv5mtgxj9j6XWVx1KF
 +mJfb2DZlvii0ubuTm+n/ietEYJx17tyqzxd6XXIG63QLyPhezo5iAVU4ri8iJ0tEwEf
 PPvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoIdsoOPq9V9m0ZDDL9phTcuXxv70Qf6zj0jZlZhPdhUKBfGsEbdLXdipx/rYHcpHGYY4M7wlwuFhng@nongnu.org
X-Gm-Message-State: AOJu0YyfZlDwKFEpTVFUN+H2ZHj0M1/aZC4/qjr7Ea77Z8UFrsQaZC7h
 qrHQfTtvz9frpnYs+M/EESmWbh59V7h5F3UllKh719CrzdQPPMN7Tw07wJkoM6wb0AfQt3CpvAi
 yWF0P91gpnYV0i3ggHUb+DmLjzUePkZQ3RGGNnpmeTQ5gu+3780xIMDu8xg==
X-Gm-Gg: AfdE7cnebpnM+vpfbm7UnpPAxO2utxOVsaRMIiZIMTH6KeZRbEi1KDKi4vWVA6Sdhx1
 Fj9+wRi5oYIShuOyNEEzWYOqLRSFjS1E3f39sTmX1oEHh8VdocFm+rudBH3oohYwS+y37x4rD3k
 Tl+5ZO8fjwH6VTeTFNCTZlITtrrE9k0Ndcn8d9yrtAklxGvGsk50CMh+0KD1q7TdLCm2Qbp1wKC
 XgA4cYjA02O5MoA8o05RU+QwUtZyHL3vm6r2wzKGYGRmr3+qCxFeMeRJRSHhAft+WfMNAMtemKN
 WaUGWDfilkNeILHeNRY9JIOnmAU/laoR0z36GQPKbISR6RInmzdg667qlHoV2NOUpmKqL+Jrsdf
 3dcrz13iZp/6Vmc4HJu7GOCg3RAo389IWmydhfY4FNh+dH7BoAMpsKAMmZuJZlg==
X-Received: by 2002:ac8:6112:0:b0:517:c699:3387 with SMTP id
 d75a77b69052e-51caa177f52mr130386371cf.37.1783926422036; 
 Mon, 13 Jul 2026 00:07:02 -0700 (PDT)
X-Received: by 2002:ac8:6112:0:b0:517:c699:3387 with SMTP id
 d75a77b69052e-51caa177f52mr130386141cf.37.1783926421574; 
 Mon, 13 Jul 2026 00:07:01 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6ea082sm368306475e9.11.2026.07.13.00.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 00:07:00 -0700 (PDT)
Message-ID: <038661b9-d311-479c-a93d-d98f60e28c58@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 09:06:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/ivshmem: clear chardev handlers before freeing
 peers
Content-Language: en-US
To: =?UTF-8?B?c3VuZGF5amlhbmco6JKL5rWp5aSpKQ==?= <sundayjiang@tencent.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <tencent_3105EC28797360A155078F53@qq.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <tencent_3105EC28797360A155078F53@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3MSBTYWx0ZWRfXx9iJB7/Rxl+9
 3RXOUuGFXM+UfxgbTjgF2dM+mXuRnJK/Tze5cNvpHkTr4P3WE6KHlmHu0XdqG7hsJOp7fRoptaS
 kaO2N5tipn0RfdhVVQzu80/+kKFq7znWJm6ZtvmKERaZsM0T1zLOScmfiiKWS9yBCGjU3QRR4QR
 9Lb3GsmzhN/wDwpI4ITZ5c4Se0EPWlbMl0/yC5VYWJ/rjLKrX7Mt3Riu6c7EYGewOQ6Y6Xjqg40
 OcQmRFdtRTYnEGt9CfXLrBJoFfAv3jca5IQ0qBQoEYZzrpkWyOYsPU8hv5MFPnPvkSJKF9hf7qV
 dblEAQ7czMdqvfi7RWyxFAxnUk98GUAiwDe+0stPGIXQEzs3vSxI9KvzHX5PMo+ET9v6gHlivVV
 ierVzjiJNSyKTPFrg8Ej7BAGfBMyR19psCzm/EwoW/UujM1ceNkggZuEiOf6ZzM+3QX2cieRBmI
 q4hCzoFt0FGQd07j/sw==
X-Proofpoint-ORIG-GUID: KMr_LpjgSegYnCid-Ii-QCc5Np2tmzo9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3MSBTYWx0ZWRfX3jPTmO6mqfpx
 kYCjcKxpwp9u3aOgDSuKge8vJNcpay0V+QjdzbAg7alUzF2TjuKecvWp7oK0xdTu/RRQCCuFBw+
 1LArUsHRyHF1pyP8wXDkC2mXHmc4icA=
X-Proofpoint-GUID: KMr_LpjgSegYnCid-Ii-QCc5Np2tmzo9
X-Authority-Analysis: v=2.4 cv=aaJRWxot c=1 sm=1 tr=0 ts=6a548e97 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=GvQkQWPkAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8
 a=kD1aHXNoiUmW-fgF_RsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130071
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

Cc'ing Gustavo

On 29/6/26 04:59, sundayjiang(èæµ©å¤©) wrote:
>  From 2a7fa17cd21d0a5c1ddf0f13f5c6b39375052aef Mon Sep 17 00:00:00 2001From: Haotian Jiang <sundayjiang@tencent.com&gt;
> Date: Mon, 29 Jun 2026 10:50:21 +0800
> Subject: [PATCH] hw/misc/ivshmem: clear chardev handlers before freeing peers
> 
> 
> ivshmem_exit() frees s-&gt;peers and s-&gt;msi_vectors but does not clear
> the chardev handlers registered in ivshmem_common_realize(). &nbsp;Those
> handlers are only removed later in object_finalize() via release_chr,
> which runs after ivshmem_exit().
> 
> 
> Between exit and finalize, ivshmem_read() can fire on pending chardev
> data and process_msg_connect() dereferences the freed s-&gt;peers.
> Additionally, s-&gt;peers, s-&gt;nb_peers, and s-&gt;msi_vectors are not
> zeroed after free, leaving dangling pointers that make the UAF code
> paths reachable.
> 
> 
> Fix by clearing chardev handlers at the beginning of ivshmem_exit(),
> before any resources they access are freed, and nullifying freed
> pointers.
> 
> 
> Fixes: f64a078d45a ("ivshmem: fix pci_ivshmem_exit()")
> Link: https://gitlab.com/qemu-project/qemu/-/work_items/3594
> Reported-by: Haotian Jiang <sundayjiang@tencent.com&gt;
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Haotian Jiang <sundayjiang@tencent.com&gt;
> ---
> &nbsp;hw/misc/ivshmem-pci.c | 6 ++++++
> &nbsp;1 file changed, 6 insertions(+)
> 
> 
> diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
> index c987eebb98..ce0de5271e 100644
> --- a/hw/misc/ivshmem-pci.c
> +++ b/hw/misc/ivshmem-pci.c
> @@ -938,6 +938,9 @@ static void ivshmem_exit(PCIDevice *dev)
> &nbsp; &nbsp; &nbsp;IVShmemState *s = IVSHMEM_COMMON(dev);
> &nbsp; &nbsp; &nbsp;int i;
> &nbsp;
> + &nbsp; &nbsp;qemu_chr_fe_set_handlers(&amp;s-&gt;server_chr, NULL, NULL, NULL, NULL,
> + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; NULL, NULL, true);
> +
> &nbsp; &nbsp; &nbsp;migrate_del_blocker(&amp;s-&gt;migration_blocker);
> &nbsp;
> &nbsp; &nbsp; &nbsp;if (memory_region_is_mapped(s-&gt;ivshmem_bar2)) {
> @@ -966,6 +969,8 @@ static void ivshmem_exit(PCIDevice *dev)
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;close_peer_eventfds(s, i);
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;}
> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;g_free(s-&gt;peers);
> + &nbsp; &nbsp; &nbsp; &nbsp;s-&gt;peers = NULL;
> + &nbsp; &nbsp; &nbsp; &nbsp;s-&gt;nb_peers = 0;
> &nbsp; &nbsp; &nbsp;}
> &nbsp;
> &nbsp; &nbsp; &nbsp;if (ivshmem_has_feature(s, IVSHMEM_MSI)) {
> @@ -973,6 +978,7 @@ static void ivshmem_exit(PCIDevice *dev)
> &nbsp; &nbsp; &nbsp;}
> &nbsp;
> &nbsp; &nbsp; &nbsp;g_free(s-&gt;msi_vectors);
> + &nbsp; &nbsp;s-&gt;msi_vectors = NULL;
> &nbsp;}
> &nbsp;
> &nbsp;static int ivshmem_pre_load(void *opaque)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


