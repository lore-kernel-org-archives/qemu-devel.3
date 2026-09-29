Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3FFECA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBT2O-0000cV-UI; Tue, 29 Sep 2026 04:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1xBT2M-0000bs-9p
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:18:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew.jones@oss.qualcomm.com>)
 id 1xBT2K-0001Rp-EM
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 04:18:06 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T7Tqxd3220638
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=o6oLeLiRcQnXgMvSN6kRlc5o
 tb+PiiUDWn6qg2Ax2Yg=; b=EtCvC2P0kaDCf+7fLayfLepLOzXj2gHt61jYw0vS
 EYpBcuouaEet8PJUWXfLUVDYuDte8RHJvh6HtTi8R8Tgi+IncEQIsIvuuY0Mwdxa
 Bl5v/XW9vvJ6GV1fLF0jpZ3SsgINyl27XG44hWfNubbamvmbJLsXSlWGPXbFIlKM
 P/Ahvw+j85ANmXBFdrMesw9XSQ015vB5+m7ezFagy88B1ZiY3vweI1ZE0ghYjBhv
 jHTA1khT+ppBayGGi4nf5dDNeZr/dKRziYT078hLDDWKwzUgIR6f3S3fVz96umlY
 nMPLTyq3TlxSmL4x6NlpVVV71ImUuRBIYfCi4M5yypS7Ag==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvw230qd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:18:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a082c014aso147794685a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 01:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790669881; x=1791274681; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=o6oLeLiRcQnXgMvSN6kRlc5otb+PiiUDWn6qg2Ax2Yg=;
 b=DJc1Yy1ys6DbJIv2dREDBwLnCiaJ8/DjFAs82BRQdyfUxwzcbmZ0AJAdsv//aFQd1x
 ntmb2ljFGqV/FDiapKyGtJWHBSKNkvkKgmdl5o9gYeG6+CV1vtAziHS4LBqkHwJ8pCJw
 0zB0vYvZZ11gr9vZVInCKPnoyRHQyaQd4UDwTLwWxEuB5+VzYfMkSn2yJ5eH6zMIjzuN
 9n2+yVAPBlIOwpEMiOkV9okga46gfNz4ymofzhgjGIP2nkBj3bDj5cgqMntnP2dHxkvU
 e8EcPmW1piKP7/0GF2LeohIFESzPmVcqgqfNCscgqKcnkRPnNShdvPH6zKtsbqO9s7xf
 dTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790669881; x=1791274681;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=o6oLeLiRcQnXgMvSN6kRlc5otb+PiiUDWn6qg2Ax2Yg=;
 b=xRkBTN3NmChEoZhw6191k0sgEISWudoTHB6rQMS42XFirSDHwndVex29zcAkhlvfTv
 R/2b0rR+PeSX+N/3WBDyyhNAQkZgEhNAJywynwmAfgvEt+2hcu1otbUr7PrTVrhYQNs0
 YJ720LDGEUAGScABWwI0zXw930y8oUKQ0CaEcvt10NJmOuwG1iAA2pf6vX9VR8nDwG/C
 tWvMxyVVuT5A62QHHWuIDCKK8oBSgExyrzO9kjaStTi4hnycoNYEsLkGeRK6VtTXZP42
 wC+Zfpz9xgfA5/N9tsYIxwP8PXtDYyb5PTG2m/GLzjfh5m+bTyfz9mjBtI3wuVdg8GkZ
 0ySg==
X-Gm-Message-State: AFuF++n/9IVXg80MJu7TfKbeQpe1dP33DQKE4SoqdmTI215/MOI/wGGO
 ZKiJoNxEMh3ejoYjLre4kfXk45+6A40pwvyjpaCDuGmUa3Yvu9lDJeXfLjEeLeTj5j8OZpXjh39
 B7rVitq0TMjEUndzNqt0+JU4BSQIxyaxL+bU+xJKxgp2tpgcKNP6Ps1LVGg==
X-Gm-Gg: AYBFou11xddpzwNvMdWKPHBYh+IBHftLRURklY5N7MwHa/SWdw/cUARLyvl6id4+r7M
 If2JRgPVeqdYtNh1YygAhLKOM43rFxY6ErPOKeXJQoZQWvE7hl/hdeR21ZF7BFcPtGUMYNZtJrk
 WQi3Q7EZaIYA3uzYc0qJU7JI7OROjWTtxcMhftVFQGzHdcIK6TCfKWdoG97w+mRKi7Ptb9WPHC1
 NTaUjmn/YTSrpAO0HQZItzsU7E9C7Y0liRIaHg5TIkTAvSAEfRjwfU/P9tt9Fawz4NCY3ZgRxmN
 risuaLMwlFIaOze34uV4F1KJkZE5CgFX6VznSnoAWtQgmVT8jaYHkkRWOHWSRwsJjgS7zOsygbW
 XlR4qNQ8+FaPldI25LyYDqLM5p8DmJitvB5mW0w==
X-Received: by 2002:a05:620a:880c:b0:939:a095:e458 with SMTP id
 af79cd13be357-93c8bcd0262mr319150385a.3.1790669881213; 
 Tue, 29 Sep 2026 01:18:01 -0700 (PDT)
X-Received: by 2002:a05:620a:880c:b0:939:a095:e458 with SMTP id
 af79cd13be357-93c8bcd0262mr319147085a.3.1790669880717; 
 Tue, 29 Sep 2026 01:18:00 -0700 (PDT)
Received: from localhost (ip-86-49-245-11.bb.vodafone.cz. [86.49.245.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6acb9037302sm378372a12.28.2026.09.29.01.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:17:59 -0700 (PDT)
Date: Tue, 29 Sep 2026 10:17:58 +0200
From: Andrew Jones <andrew.jones@oss.qualcomm.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v13 5/5] docs: add riscv-server-ref.rst
Message-ID: <kyvzb7b6rtjbei6ox7wr4cxbpqqv7qz6fyiief4mn4m3wkklu3@hdfiylwaihgs>
References: <20260928201107.2049458-1-daniel.barboza@oss.qualcomm.com>
 <20260928201107.2049458-6-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928201107.2049458-6-daniel.barboza@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=N6i8hG9B c=1 sm=1 tr=0 ts=6abb743a cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4CXLxsOAgPM/krjtHEZQyA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=FRSEYCzRAAAA:8 a=r-YDLeC8pWfmBPvFspwA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=xVlTc564ipvMDusKsbsT:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: f1axVoU-dgOHwJNTijvAdIssZMAseF3h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzMiBTYWx0ZWRfX2fEQlqjeoGg6
 vyK8nS3M2/R8ln7jfw4NkPnSBxHbs+wuPMQnRHwJXo51QgCkiYJX68DrjB5zGt05o2ci2Jl765l
 LsG2xOsb4bmX7iXT+61kLj/P4sH+hLUjhm9HCqPhE/fbreRqzG5gpFbecB4eMNcMh1DRMZoH6kd
 ueDnQLy1AtGwbTQG6ve/8qevwEugXWikUwQFjjcUyN16ZC4qogXrJqX179//G3Njbkql3FGDPvW
 BW8uxIwZQaQRbDoLg8KuNQJ3OpuYQosufUSpEcg6el0OqWdqs7DvzZq7XKy1ve31yJOYNNGGYr4
 m6u6SejgBFgy6R7+dkWoadx1ZXOvEB1CxuJkpCjjHxRQR3gmtDeZbe5fH9XNsDMf7QyWWGWZDDH
 oB+hwkFNPxJiadi3Hx5/RhakK81y5NeeaFBnnHvxAuQLVUuJ8a+/8V5FOz9Gc6XB36ewWVTCalF
 tn8qylNHfUX/+frldTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzMiBTYWx0ZWRfXyiRPT6napwXI
 fs/YuqnpAoqJffXi6i4vwPv7I6knYDpeM0Jkpo71BsTIOqs7pd/XUvqKWwSwQrsAwwv0RmxAXHh
 JXAn1/lpGwhhNQAtPr9lVcwt0kjaxQ0=
X-Proofpoint-GUID: f1axVoU-dgOHwJNTijvAdIssZMAseF3h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290032
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=andrew.jones@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On Mon, Sep 28, 2026 at 05:11:06PM -0300, Daniel Henrique Barboza wrote:
> Add documentation for the new riscv-server-ref board.
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Chao Liu <chao.liu@processmission.com>
> Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>
> ---
>  docs/system/riscv/riscv-server-ref.rst | 65 ++++++++++++++++++++++++++
>  docs/system/target-riscv.rst           |  1 +
>  2 files changed, 66 insertions(+)
>  create mode 100644 docs/system/riscv/riscv-server-ref.rst
>

Reviewed-by: Andrew Jones <andrew.jones@oss.qualcomm.com>

