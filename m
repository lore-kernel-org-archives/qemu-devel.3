Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE46CA9ED6
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7Uf-0002IW-HA; Mon, 12 Oct 2026 00:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7UH-0001yD-9C
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:18:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7UE-0001Au-Li
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:18:09 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lLDP916025
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8Rh+yfMK21+Twp8R38b7YOL1KJyCqBmyFbRm4oS4gIA=; b=FFqzNEaRIP6ezm7U
 DE1wDwt0NNwVHH6SZlx5ZRnz/9Qk1ovvCb4FZV/oQ2EDfRSocOvhaILFz3ZPIbEO
 U6WzyXx76XHsVYWk2bJ55y3bWurul2//SFAFF1w0Q153sZuFXJoJvp9VTdkVhg3C
 gom3A19Xt15iF0ivLijayYlgqoPr+fxugmCNZZgJIY+0fqwwNRb5FKuWNwHwJvAH
 t6GJDfDVxwsiOf0/RH4JL4JhUxsPvJcGEADxWAkA7u5I7L0TQORUs9zHnsRrPlki
 FuPB8Dizsn+Dw7FIIBiw6rE6BtENtqU87WXll6cAhk4ThSNCt337JF9rrH3DLkET
 T4yHuQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7dk24nd1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:17:53 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso3199548eec.0
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791778673; x=1792383473; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8Rh+yfMK21+Twp8R38b7YOL1KJyCqBmyFbRm4oS4gIA=;
 b=Sk61IKRmLkvQ9efJ/82olWUHSCLa+NiNP+lk9TX08WpDKusdNZwdc4jA6GkgeOoaR0
 uEcjsFatX2EHkhjJ7/Lq1AF+pF/YgkU2Otb/gOAOkU9eK1x1Okjo4PSAoJ966tgEfTjq
 NfVYF9cmWBjOwGBXgo7lBMW8sVRhtHQCJWIcsPo3tlJYBn6WknWRapBxK0kcpkH0wfkp
 7i4dobOrFvy7iM9qBv/2mffWvz18G4UbvjMl795ZYnJslUvEs3dAJ0Kjv8d5zPrscOk+
 rbo+pGLocOVT/i7PPAIPrTfVfR7Mo8XpyOjqLrE5ZwHe6Ncva14k0TkqZlPaCK/U7W3H
 ACwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791778673; x=1792383473;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Rh+yfMK21+Twp8R38b7YOL1KJyCqBmyFbRm4oS4gIA=;
 b=oUxd4st0WU9tv2Jivzu6ccNSjrDGBNpgwWuoQtkLeOiQK3ApBxQySHzjsPjvsLq+xI
 Pfu4JSStCGXgEBTluZDwGBZz8AwNcPDFBreqeN3aCOyruTKaxchU4jwH2sqbo6WJV4ED
 HHcxQsv4Zl9G+scxIVXN2uNEnIqccoR0L7fRuCk4nnuGXq+lG59hzOWjDtHcGqiZivGz
 3C01iIhCA9sSHnq72j/TikP4kw5Fvecg3dTL6u9BEgGeP+xSXeHoGpS+W6pRIKnTVFQL
 9CIP3PIhDvBUvx/peHHQTb9MedIkqw63lijc+UeGUjfMCdJhtBxle96a1hY1yldMbWgi
 g2mQ==
X-Gm-Message-State: AFq9FYK2HOfZtrOiM1BoVB3Jk41/Zi6/ThdAwznbEDBLgQHODe5Isg6o
 PLKuilqbcf2nVC+C+mMVndKSINBd+k1XMCFPsZ72+AThV+OV8AgR00lvqIRU9aGc1ELOzV3Mk46
 3bPfpqo7X7IPMn8QSPEMN8RrVZwbpcr64nQ7B/IdUX3GMO3g9a1enYdgV9micVCz8/g==
X-Gm-Gg: AYBFou2sWgNuOtOZ6T1SfnS+U/+D3wC/tgSxIO+BFUXhly/qqQVdwLL24lWJYVe/Zx8
 sWTjxSv4zUngE/FuLH/FK6py/sf7yxAs+mXYOE8WmmvqxxFoxRmJdWJHTZqa9rt2W5IWzM5fufk
 r1SLEgDB/V9MNXJlVO2Z9qYUVTcEnfA++yf6FITrJd8cXCcokqwhHq4LnznKi3AZvDs2wyPLCqR
 bL6ChBXTvapALkTO8RSpy0o3f4gqT2wOyuR6virPesUDlKgUWAdNYbG6YL+iCl/KZS7lY6APq+P
 RrpQneU8vqH1JoEZbJNvKtIpcAmwhXA0HdA+hqJ3QHtK0KYzZ07LSQf+5Eu3/8Hs3GKnmq5eZyr
 7t9OcHDV9edwZY2V0w4T5+5un7DfEN8r4O+wlLHLx2ZqHyE8=
X-Received: by 2002:a05:7300:8195:b0:350:869:d106 with SMTP id
 5a478bee46e88-3537e2363d1mr16069888eec.34.1791778673034; 
 Sun, 11 Oct 2026 21:17:53 -0700 (PDT)
X-Received: by 2002:a05:7300:8195:b0:350:869:d106 with SMTP id
 5a478bee46e88-3537e2363d1mr16069853eec.34.1791778672464; 
 Sun, 11 Oct 2026 21:17:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm32369096eec.3.2026.10.11.21.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 21:17:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL 17/25] linux-user/hexagon: add v75-v81 HWCAPs
Date: Sun, 11 Oct 2026 21:17:14 -0700
Message-Id: <20261012041722.1159355-18-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
References: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: yQ4G7-QGh5jOjjUdbzYUq0pdA2gfegxZ
X-Proofpoint-GUID: yQ4G7-QGh5jOjjUdbzYUq0pdA2gfegxZ
X-Authority-Analysis: v=2.4 cv=E6hYNqdl c=1 sm=1 tr=0 ts=6acc5f71 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=BRFeZrn0LRIrCjf-XoEA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX70CdxRlK0qlw
 jOWM5vchnQ08KdvMHQy/nKuUYGGTwZL3aKLOdEEXNolZuHkarSeqUuiBXXSumUdSsZrrKc1SyMs
 /fdBJMFe93CS7MU645BpUW/fh/OxX2y+QUCJSkQPgUoyTDyF1uuuxuTnZrSuYIYVj/cVFwrx2Ls
 GQ404G5SlEx7yFqz6q+V2ua9b48MAndGULDO8bir0Yc5SM6xI/P8bTCR7upHUu9Wrz/+pW0h8AF
 CfbN5zGeGZo2qCWqh9dTC4pNkwXDt6pZ9VDy8oQ2X887T2w/F3f42xx/vWFL5qm2ahRGt71XxMd
 tRMrVdWW/WAFO0Xi0HXKVbGz/LhEqEgGJ6kanf2i2PBuxKDhMN9Q9S+JCAhCmTpF+BNl6PPlO+Y
 I5rnYaGwATo6tPXgLqp+ZRl9HxrZlU5H+5njlQRTV+6CtMtvUS++OfPLd9iC0Znlv2AXLgfaGr0
 6w6DmgBHU/Vf6VsKWyg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX7JzN8kp+M897
 nkoDIiSY7G/6obOM+QH95FvFLJZ0/oqL3rC38kucj6db/QG18c0pDW+3z7ra5Ab/BkczeC2EMCb
 2ilore3/ihvK3BSHpjk8Z/kuOiyzh5A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120016
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

UmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiBsaW51eC11c2VyL2hleGFnb24vZWxmbG9hZC5jIHwgOSArKysrKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9saW51eC11c2VyL2hleGFnb24v
ZWxmbG9hZC5jIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwppbmRleCA0NDA1MzJlZTQx
My4uM2E2YmE0ZTEzMDQgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMK
KysrIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpAQCAtNTMsNiArNTMsMTUgQEAgYWJp
X3Vsb25nIGdldF9lbGZfaHdjYXAoQ1BVU3RhdGUgKmNzKQogICAgIGNhc2UgSEVYX1ZFUl9WNzM6
CiAgICAgICAgIGh3Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNBX1Y3MzsKICAgICAgICAgYnJlYWs7
CisgICAgY2FzZSBIRVhfVkVSX1Y3NToKKyAgICAgICAgaHdjYXBzID0gSFdDQVBfSEVYQUdPTl9J
U0FfVjc1OworICAgICAgICBicmVhazsKKyAgICBjYXNlIEhFWF9WRVJfVjc5OgorICAgICAgICBo
d2NhcHMgPSBIV0NBUF9IRVhBR09OX0lTQV9WNzk7CisgICAgICAgIGJyZWFrOworICAgIGNhc2Ug
SEVYX1ZFUl9WODE6CisgICAgICAgIGh3Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNBX1Y4MTsKKyAg
ICAgICAgYnJlYWs7CiAgICAgZGVmYXVsdDoKICAgICAgICAgcmV0dXJuIDA7CiAgICAgfQotLSAK
Mi4zNC4xCgo=

