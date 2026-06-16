Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6439CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 17:58:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZY3M-0008Mp-Fh; Tue, 16 Jun 2026 13:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZY3H-0008MH-H3
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:58:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZY3F-0003vR-19
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 13:58:18 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GH9Jtn3747657
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 17:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /dL1JyC6YJ1iyDWPShqpW07wmrjx71zCN0ozXMyYq3w=; b=UGxJ4ajL9v9SFg7L
 rLWYqwXd3Cty1g0IK0Hhip1TEgIT59ov1WmfYGDXjJkkOzxWP5VoHEgmZ23wnqSM
 tZE7abdc5U9v95UjM9RN/l0Bq/KiN2bNX5rTy4Q17r5yg2FEix4VD9bDA07G/jWi
 s7Q4UzNhhw93J7UiqMDz3IilDxGCjclpTz+OhOfqorHJ+ocEkTIWzRZC1EFwldLl
 Dc7w2Y6ou83r13LLSkwp5jmtMZuU4/K0oM+gKGa350xE5qtPeE66J1C4UzS1j1xG
 1QMjlhxUllGkJb5qWpfLL8yGovYDIiXUjIat3UkMPg+Vh0zUBjtWJksYeFkvzXVp
 CNXihQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu0a7ucgt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 17:58:15 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30ba395b047so3625818eec.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 10:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781632694; x=1782237494; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/dL1JyC6YJ1iyDWPShqpW07wmrjx71zCN0ozXMyYq3w=;
 b=fOyctAPD+XiTmkHXr927gK/wmLIVdNMcue6mQEMxyHu9Z1hcaVptzr0KzXmK5kx1N/
 KduRfCK5j65jVvpyBobJYP0Ov0C0cCOwji3EAnSBAMjCx5123y2sudPZGGOEhO7LpWyj
 I2j4dE/SFwPwu++tT6++WyUWruQWPdBRljLQvKzk6FUNHTHZ9XfKMVAXP94FoyR5woTt
 VOixsgyLZce1SbBbhgr687wWzM22YReGT3uRJrYizDTaoUIQAA2cTvxLLCAGjv43JeXs
 cwWO7+ZGj1G6ZcsvQjxdrqEGgSNBoPA4dsD8j33XVL06DuqnE8lE1A+yK2otRyfjGuY0
 aIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781632694; x=1782237494;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/dL1JyC6YJ1iyDWPShqpW07wmrjx71zCN0ozXMyYq3w=;
 b=gqRBHu8aBo8Ut2mVMBxBWhbBNwOdYOW5mhCOCFlsJzbO9+nL5AOuB/4dQWEqTFj9e0
 EkTmeaw5aSVMdRVUbC1TNt2bST4Ws65StzDwcE22HD2dz+oLGpnWtCZV5yWaC/phH5DY
 atkF6zlsJ7KFsMR09pOry2Ft6UYUMjVeOck+thGog4pYx9KLbsHXDIFX8fEcmiGZ1Gvk
 YkC6ZQQW/w4citPAfjEIrXV/R8UQQPMTAUCIz9DwFivG4IpMx2xvG3FV1WMYqWOOCJQg
 TpNbKeTbyi7/XzDYPNUAIGvTJzOMFwyh6KbAMD0R4KXmTRJVioo2X0OPOm6JQmgEM7Nx
 KMDg==
X-Gm-Message-State: AOJu0Ywt5ksC9Ym3Z0MiPaYesLnV2UsxIInQU8ITDvOEYDM3DHqjpfle
 iO+Exyp/QLkVjt17iCT2rUJUFwJSgDK2F5Hto5EJStA/5WJO6IBz7OgQUhM8wpKoliDvM6b8ntx
 HwB8EN0KT2U7PYYci24eJMhIzqkwcj9gZngcGSGjAuVOfDQhtUT3LM6qMOPh9TcQxYrw+
X-Gm-Gg: Acq92OHkV9TjKPp6jRQ0PMK650IoIVECvGbvE7W6KaFI59qhSBdb11BEdLl4Rp/o1SD
 TMXTcbOrQ/DwwhXX+Jbz/P4ckIHQzBiwjmA9YK8bB/BRWTbE+jIVWkv+Brctt0cK1BPJewDnAIS
 ysHCtZnPEfCgoAcCQiOv4I5lM6xiw0Pg8t0/b2gxaG8E/1Qx4pZgNFwvZwI8Yn0CVnBP1azl85c
 HLJ5kL7YPU74RKCyl8QvBZ6FXJsIqJKtGI6TyCPu0GtKYgC0VI1+evoz0v/w4Sp7nVVGb1OVcCi
 59d4lbswswDvfNoE9XvzRfKR5IN0oqsicMnn8uyn1rWhNeZ+sz93FthbEb0ZpMl+qYbEM2CyHr9
 63aByiLNZLSH1FWqtWrz0OeKTYTULyJSeDVHtAcA5oEElgONEBNUZzeKXDYcv79l6tQmI+HT5Zs
 koeggQzrjFfl/M1w==
X-Received: by 2002:a05:7300:cb0a:b0:304:de8e:17b with SMTP id
 5a478bee46e88-30bc998d5e5mr308164eec.5.1781632694257; 
 Tue, 16 Jun 2026 10:58:14 -0700 (PDT)
X-Received: by 2002:a05:7300:cb0a:b0:304:de8e:17b with SMTP id
 5a478bee46e88-30bc998d5e5mr308133eec.5.1781632693704; 
 Tue, 16 Jun 2026 10:58:13 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e48bfa7sm19835240eec.5.2026.06.16.10.58.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jun 2026 10:58:13 -0700 (PDT)
Message-ID: <ddfdfbf1-ffc9-47d9-8319-cbc9a6d03e65@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 10:58:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Docs update for 2026-06-16
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
References: <20260616175316.264758-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260616175316.264758-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE4NCBTYWx0ZWRfX8JhU3MaKpLns
 cbzvSaQVs8WIi3THqYDfkS4aEwnotuFye/wBXJGDQI6PfYmLKTZskuI4EAhe3b4XqBRv+ltXP2R
 fM7BtCVPrDLo2jkTl8ozmLqPU3GTdil7v1y90IaCKvtooXqcd6vNHiIVQHTKxhY3VGKpVc6/JHQ
 js0rwz1yjB19l8S6hRpeu/AebzJJ/zytoXuT5qztQcS+ZWbPW1l2iVdYMzoFIo0v3Px9OK+Tv0i
 iWQeHYnZnX1NHaHpZs6CliepqbdTl6p/wNw8uQwXHDFKNkKh9fbCHTlc/qtJ6RMM5Mq3e4UabNL
 xAYTJtXlvZxKt49S5I4/HnkC9lerHuIqP+LLlasAxAZ1Yxd82faymaXXhNFXVFY1GHXHmtx3txi
 qr8pTYBzISZ2C7H27q5hEciRNzcizW2u/pAHbgSNDUjRZuytmVkbrwIe0W4/lzH5JpKgPnh6DIt
 zVOPQcWp6souuyRc26g==
X-Authority-Analysis: v=2.4 cv=JKALdcKb c=1 sm=1 tr=0 ts=6a318eb7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=9hThhU4vM5iOpYgWJg0A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: NPvL_aqyuX35GGrd877KzEZi6uAANQXI
X-Proofpoint-GUID: NPvL_aqyuX35GGrd877KzEZi6uAANQXI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE4NCBTYWx0ZWRfX9ZSUSXf7049Y
 /Ag6UCYn5tGgfba8h2dBMetxgbSSTL0rZJCIDt8K592GABV/VPCUOqbeCmFvKJlMV5KNakKvFBv
 TpIq/gAYnPnxryUKxPCKsivMxvGClX4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160184
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

On 6/16/2026 10:53 AM, Pierrick Bouvier wrote:
> The following changes since commit b0df6e2f2c6c45df8d4d286933799c623e124d98:
> 
>   Merge tag 'pull-riscv-to-apply-20260616' of https://github.com/alistair23/qemu into staging (2026-06-16 10:41:47 -0400)
> 
> are available in the Git repository at:
> 
>   https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/docs-20260616
> 
> for you to fetch changes up to f00622a929b296902f9b23a5fd5dc1b5988e669a:
> 
>   add a note on -shim to direct kernel boot docs (2026-06-16 10:48:14 -0700)
> 
> ----------------------------------------------------------------
> Changes:
> - [PATCH v2] add a note on -shim to direct kernel boot docs (Gerd Hoffmann <kraxel@redhat.com>)
>   Link: https://lore.kernel.org/qemu-devel/20260612161707.158029-1-kraxel@redhat.com
> 
> ----------------------------------------------------------------
> Gerd Hoffmann (1):
>       add a note on -shim to direct kernel boot docs
> 
>  docs/system/linuxboot.rst | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)

Please ignore this PR, as the patch has incorrect content that was added
when amending it.

The correct PR is:
https://lore.kernel.org/qemu-devel/20260616175535.268519-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Sorry for the noise,
Pierrick

