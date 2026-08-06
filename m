Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4543C55838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 04:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrpmi-0002AO-Sf; Thu, 06 Aug 2026 00:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpmS-00027Z-Py
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:32:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrpmQ-00045O-Fs
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 00:32:32 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675NbMLV170489
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 04:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vimfb4mB5Y/rzzknLn+teggVHiC4aAHA6lBicXhjL6o=; b=KtOq4P84B9VpuXrC
 edFbFEYZzDea+wJnEgzzfpxM14rPOFi/KMAY2SPgmO3npfMOP4Z0wIkWIEribeu1
 FJ9dvIzru9P8CigLOYrJl7AzdwU5nUbn0FUgqfbLxOWLtMupLVIkmI3H3zXETS03
 jmP4cVs2BD1U4CzOdhJxkIzs60vBSZCfOt7F4cyMTLF9OCDi0rlEw6K/m7SdQk+H
 OQXXy063V3WQrcsanGzR72OtX1paotqU6K05+1s7/oXPT5sAxync5iV1Z8WU6Lr+
 EwAYgv6QrOnemEOU0qvXYnNRrEvpl84HaRLmzu7t1PE9K8dSMahKRnpiK0hX3rgp
 QVjY1w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x5uk2h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 04:32:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so2477598a91.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 21:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785990749; x=1786595549; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vimfb4mB5Y/rzzknLn+teggVHiC4aAHA6lBicXhjL6o=;
 b=QUcPQMet+qcij+RUrtEpmMYqxYPftNYL24aOK1nWXZ88QEwTxwfLMCSnd1vcMNYkvA
 T+18IJnwD2mLG5fNqhKVJpsFKjsdKPglHQZa+YLpNu4K3wEk066bqFwDxQeLKVbnEN/+
 F4i0SHU+l6RsCNRIwqvJMDBsr9EmyBKRKEokaanmve0U1Bf0BjvFeInAclGUqy3hovuZ
 VaLqzGyopzMXEoshD4uBbzItaqMvz7MrkGdeW3lHYZiJVEmDORaVRKK+0askQ9KMQ1XG
 XP+Fs0B72medZf2t13ExZgEiM3a8Cz11WGAkewI8+zOUgeX6gdI9e2hD7EKyg+hkGxBa
 ulNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785990749; x=1786595549;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vimfb4mB5Y/rzzknLn+teggVHiC4aAHA6lBicXhjL6o=;
 b=BE2KXEtQpU2i2GRNoimYGqPFzasIZeyVacHPZfa5wd/Ge3RyznHG/wzeYkZsn/LeqY
 T2abPXjvywHEQc0b0i0bFroyInkAMy9h+g+8bHjHaJYTs97zK5luijxR5tQstpoIN1UX
 wRo1SmckgXR3/Xsi4xeMrmh08/iAk6MEyBjmvTp5MZfZscOwZUgmGOeC59psc59Qn8+G
 O8S5kef8R3vUrheMkvo3ZltgsKwfIaRwO4G/EnzwXyWkfNtpqScvzBjt9FViRzhR5cdn
 yUHM3nGElAsMz4DnKhlkdHFhigT/6AjoaDm84iLEN5OMVJgK7Gnr1kt5rJexVMoB9gl8
 3VEw==
X-Gm-Message-State: AOJu0YwdamYkRLLg+CFFgSq0G8CFnlqmWXBIjLIR/EhcOYhGeYOFvBuS
 GSslW/hzLLD1gfdohnx6AGrEYSsx7VQu4OjHvyVX8xlgs75tsIMc7fv0B8IP5e45+zJE2cmCOhL
 3ZykHOWAVDDvzxxUfBYOaIFFO2p8Ar44X4My5LS4m71jdwSqQzti/32DVoPBR+Y2lIA==
X-Gm-Gg: AR+sD10GyFxxhQ+PRB0ToxMwzB4/guDdzsZcNzRgWInw+6xR9DWOipUq9KeurtopfNW
 ksfF3OceZiJ5U4DcideXtxUziRT3OcJ/Eitba9/BIRJQs8ZS3Nu774z9Qc9yVJ9W6xiH1Jcx6Ad
 mWDi3JvcDmIrEhTvyDJ7/fnOGe77GxBAY1XXTNEHWFPINwNBnsSdhtBmXxTR+anh0Qpn9/iEwiN
 FLQ6SLEjEMo9svq3BbL9s3Mc0w0oJXPHU7i+2WJ6zUz3SpniE/uS9oX54hw66Az6s1Ra3cYaVh4
 pcVEHwyqE4y3TpI96sz3DpL+CwubzC5l6jasGiRTsWeQ3cAH4zdOe6ISdG3vVzZMr7yN12paZK0
 dhXAw86j9pv7e8/63Xi3i0uggizS1WNGaaeSCvoNMaZwBFFiD
X-Received: by 2002:a17:90b:2245:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-3903c5a6abbmr8761533a91.10.1785990748572; 
 Wed, 05 Aug 2026 21:32:28 -0700 (PDT)
X-Received: by 2002:a17:90b:2245:b0:36b:bec8:94c5 with SMTP id
 98e67ed59e1d1-3903c5a6abbmr8761498a91.10.1785990747989; 
 Wed, 05 Aug 2026 21:32:27 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0a9csm29958146eec.2.2026.08.05.21.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 21:32:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com,
 Brian Cain <brian.cain@oss.qualcomm.com>, richard.henderson@linaro.org
Subject: [PATCH v2 2/6] target/hexagon: add GVec overrides for HVX saturating
 add/sub
Date: Wed,  5 Aug 2026 21:32:19 -0700
Message-Id: <20260806043223.3787083-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260806043223.3787083-1-brian.cain@oss.qualcomm.com>
References: <20260806043223.3787083-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: c9ni_TQsHJcjj0INatL857fv71AcuzBN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzMSBTYWx0ZWRfX+bQl9muMLvUs
 ZNqc8LFWJ32fs8uonsCppOEJKMkom4N1lyPv/5Kfr778Bd0E9HbcpkxQ96ZFZ3v6gnvHR52d/5I
 vqo7C3sekcKTA2MXgYjC3St6bUj999SfgKMXK5dX+fAtVy6MuO65TiAQoVGoG/cFQw3ghQ9F6WZ
 DFVfWdcvotlSGLw3QE8lYUIxagaJUVlWEXd6uGwb2MBHh6NSTfB1bN9FxCegdxPe28fkoH0O6mp
 lefnCbRqQgyp8nVrFu+9IsIo7Cq99Mmf+r480jPXNg2JpLhknwsCVgDmPtFmScfDP5UaytbAaow
 lq2Jr4Rq44wDmU7BHYLhuaZd71RjftKfJaLpE1esDpSnp+qQ7yWZmthsf3kch7CGSLEPTCAdX3b
 EWkEJgMxgd28PKskTLQFOKkl+vkswencudnBDhGcl2jBzsW6Ryw+OjpdzrTBKPjvnGG5zGOpyQn
 AA1Ke/CpbTOxdBHPbUA==
X-Proofpoint-ORIG-GUID: c9ni_TQsHJcjj0INatL857fv71AcuzBN
X-Authority-Analysis: v=2.4 cv=RcygzVtv c=1 sm=1 tr=0 ts=6a740e5d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=0_kjDyPZ7ljX0vQYBzoA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzMSBTYWx0ZWRfXyG1z0Qm5mfXk
 jX6Ijh3HkIVJbMHF1G59TN8wEnktHUdSni9JAiT3XE3Cd/dt1K8o8CgNkAMUw3XKh4RzD9Aza1H
 oeobdMHcLMIu5Rvg0jW9xUzMPdgv8CA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060031
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
LS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX2h2eC5oIHwgOTMgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgOTMgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2dfaHZ4LmggYi90YXJnZXQvaGV4YWdvbi9n
ZW5fdGNnX2h2eC5oCmluZGV4IDBkYTY0ZDQ2N2U2Li40M2EwZjM1OGYwMCAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19odnguaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNn
X2h2eC5oCkBAIC0yMzQsNiArMjM0LDk5IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBhc3NlcnRfdmhp
c3RfdG1wKERpc2FzQ29udGV4dCAqY3R4KQogICAgIHRjZ19nZW5fZ3ZlY19zdWIoTU9fMzIsIFZk
ZFZfb2ZmLCBWdXVWX29mZiwgVnZ2Vl9vZmYsIFwKICAgICAgICAgICAgICAgICAgICAgIHNpemVv
ZihNTVZlY3RvcikgKiAyLCBzaXplb2YoTU1WZWN0b3IpICogMikKIAorI2RlZmluZSBmR0VOX1RD
R19WNl92YWRkYnNhdChTSE9SVENPREUpIFwKKyAgICB0Y2dfZ2VuX2d2ZWNfc3NhZGQoTU9fOCwg
VmRWX29mZiwgVnVWX29mZiwgVnZWX29mZiwgXAorICAgICAgICAgICAgICAgICAgICAgICBWRUNU
T1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRFKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3Zh
ZGRoc2F0KFNIT1JUQ09ERSkgXAorICAgIHRjZ19nZW5fZ3ZlY19zc2FkZChNT18xNiwgVmRWX29m
ZiwgVnVWX29mZiwgVnZWX29mZiwgXAorICAgICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0la
RV9CWVRFLCBWRUNUT1JfU0laRV9CWVRFKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZhZGR3c2F0
KFNIT1JUQ09ERSkgXAorICAgIHRjZ19nZW5fZ3ZlY19zc2FkZChNT18zMiwgVmRWX29mZiwgVnVW
X29mZiwgVnZWX29mZiwgXAorICAgICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRF
LCBWRUNUT1JfU0laRV9CWVRFKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZhZGR1YnNhdChTSE9S
VENPREUpIFwKKyAgICB0Y2dfZ2VuX2d2ZWNfdXNhZGQoTU9fOCwgVmRWX29mZiwgVnVWX29mZiwg
VnZWX29mZiwgXAorICAgICAgICAgICAgICAgICAgICAgICBWRUNUT1JfU0laRV9CWVRFLCBWRUNU
T1JfU0laRV9CWVRFKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZhZGR1aHNhdChTSE9SVENPREUp
IFwKKyAgICB0Y2dfZ2VuX2d2ZWNfdXNhZGQoTU9fMTYsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9v
ZmYsIFwKKyAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJ
WkVfQllURSkKKworI2RlZmluZSBmR0VOX1RDR19WNl92YWRkdXdzYXQoU0hPUlRDT0RFKSBcCisg
ICAgdGNnX2dlbl9ndmVjX3VzYWRkKE1PXzMyLCBWZFZfb2ZmLCBWdVZfb2ZmLCBWdlZfb2ZmLCBc
CisgICAgICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZ
VEUpCisKKyNkZWZpbmUgZkdFTl9UQ0dfUEFJUl9BRERTVUIoT1AsIFZFQ0UsIERTVCwgU1JDX0Es
IFNSQ19CKSBcCisgICAgZG8geyBcCisgICAgICAgIHRjZ19nZW5fZ3ZlY18jI09QKFZFQ0UsIERT
VCwgU1JDX0EsIFNSQ19CLCBcCisgICAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVf
QllURSwgVkVDVE9SX1NJWkVfQllURSk7IFwKKyAgICAgICAgdGNnX2dlbl9ndmVjXyMjT1AoVkVD
RSwgRFNUICsgc2l6ZW9mKE1NVmVjdG9yKSwgXAorICAgICAgICAgICAgICAgICAgICAgICAgIFNS
Q19BICsgc2l6ZW9mKE1NVmVjdG9yKSwgXAorICAgICAgICAgICAgICAgICAgICAgICAgIFNSQ19C
ICsgc2l6ZW9mKE1NVmVjdG9yKSwgXAorICAgICAgICAgICAgICAgICAgICAgICAgIFZFQ1RPUl9T
SVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZVEUpOyBcCisgICAgfSB3aGlsZSAoMCkKKworI2RlZmlu
ZSBmR0VOX1RDR19WNl92YWRkYnNhdF9kdihTSE9SVENPREUpIFwKKyAgICBmR0VOX1RDR19QQUlS
X0FERFNVQihzc2FkZCwgTU9fOCwgVmRkVl9vZmYsIFZ1dVZfb2ZmLCBWdnZWX29mZikKKworI2Rl
ZmluZSBmR0VOX1RDR19WNl92YWRkaHNhdF9kdihTSE9SVENPREUpIFwKKyAgICBmR0VOX1RDR19Q
QUlSX0FERFNVQihzc2FkZCwgTU9fMTYsIFZkZFZfb2ZmLCBWdXVWX29mZiwgVnZ2Vl9vZmYpCisK
KyNkZWZpbmUgZkdFTl9UQ0dfVjZfdmFkZHdzYXRfZHYoU0hPUlRDT0RFKSBcCisgICAgZkdFTl9U
Q0dfUEFJUl9BRERTVUIoc3NhZGQsIE1PXzMyLCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2dlZfb2Zm
KQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZhZGR1YnNhdF9kdihTSE9SVENPREUpIFwKKyAgICBm
R0VOX1RDR19QQUlSX0FERFNVQih1c2FkZCwgTU9fOCwgVmRkVl9vZmYsIFZ1dVZfb2ZmLCBWdnZW
X29mZikKKworI2RlZmluZSBmR0VOX1RDR19WNl92YWRkdWhzYXRfZHYoU0hPUlRDT0RFKSBcCisg
ICAgZkdFTl9UQ0dfUEFJUl9BRERTVUIodXNhZGQsIE1PXzE2LCBWZGRWX29mZiwgVnV1Vl9vZmYs
IFZ2dlZfb2ZmKQorCisjZGVmaW5lIGZHRU5fVENHX1Y2X3ZhZGR1d3NhdF9kdihTSE9SVENPREUp
IFwKKyAgICBmR0VOX1RDR19QQUlSX0FERFNVQih1c2FkZCwgTU9fMzIsIFZkZFZfb2ZmLCBWdXVW
X29mZiwgVnZ2Vl9vZmYpCisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdnN1YmJzYXQoU0hPUlRDT0RF
KSBcCisgICAgdGNnX2dlbl9ndmVjX3Nzc3ViKE1PXzgsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9v
ZmYsIFwKKyAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJ
WkVfQllURSkKKworI2RlZmluZSBmR0VOX1RDR19WNl92c3ViaHNhdChTSE9SVENPREUpIFwKKyAg
ICB0Y2dfZ2VuX2d2ZWNfc3NzdWIoTU9fMTYsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYsIFwK
KyAgICAgICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllU
RSkKKworI2RlZmluZSBmR0VOX1RDR19WNl92c3Vid3NhdChTSE9SVENPREUpIFwKKyAgICB0Y2df
Z2VuX2d2ZWNfc3NzdWIoTU9fMzIsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYsIFwKKyAgICAg
ICAgICAgICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllURSkKKwor
I2RlZmluZSBmR0VOX1RDR19WNl92c3VidWJzYXQoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9n
dmVjX3Vzc3ViKE1PXzgsIFZkVl9vZmYsIFZ1Vl9vZmYsIFZ2Vl9vZmYsIFwKKyAgICAgICAgICAg
ICAgICAgICAgICAgVkVDVE9SX1NJWkVfQllURSwgVkVDVE9SX1NJWkVfQllURSkKKworI2RlZmlu
ZSBmR0VOX1RDR19WNl92c3VidWhzYXQoU0hPUlRDT0RFKSBcCisgICAgdGNnX2dlbl9ndmVjX3Vz
c3ViKE1PXzE2LCBWZFZfb2ZmLCBWdVZfb2ZmLCBWdlZfb2ZmLCBcCisgICAgICAgICAgICAgICAg
ICAgICAgIFZFQ1RPUl9TSVpFX0JZVEUsIFZFQ1RPUl9TSVpFX0JZVEUpCisKKyNkZWZpbmUgZkdF
Tl9UQ0dfVjZfdnN1YnV3c2F0KFNIT1JUQ09ERSkgXAorICAgIHRjZ19nZW5fZ3ZlY191c3N1YihN
T18zMiwgVmRWX29mZiwgVnVWX29mZiwgVnZWX29mZiwgXAorICAgICAgICAgICAgICAgICAgICAg
ICBWRUNUT1JfU0laRV9CWVRFLCBWRUNUT1JfU0laRV9CWVRFKQorCisjZGVmaW5lIGZHRU5fVENH
X1Y2X3ZzdWJic2F0X2R2KFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1BBSVJfQUREU1VCKHNz
c3ViLCBNT184LCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2dlZfb2ZmKQorCisjZGVmaW5lIGZHRU5f
VENHX1Y2X3ZzdWJoc2F0X2R2KFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1BBSVJfQUREU1VC
KHNzc3ViLCBNT18xNiwgVmRkVl9vZmYsIFZ1dVZfb2ZmLCBWdnZWX29mZikKKworI2RlZmluZSBm
R0VOX1RDR19WNl92c3Vid3NhdF9kdihTSE9SVENPREUpIFwKKyAgICBmR0VOX1RDR19QQUlSX0FE
RFNVQihzc3N1YiwgTU9fMzIsIFZkZFZfb2ZmLCBWdXVWX29mZiwgVnZ2Vl9vZmYpCisKKyNkZWZp
bmUgZkdFTl9UQ0dfVjZfdnN1YnVic2F0X2R2KFNIT1JUQ09ERSkgXAorICAgIGZHRU5fVENHX1BB
SVJfQUREU1VCKHVzc3ViLCBNT184LCBWZGRWX29mZiwgVnV1Vl9vZmYsIFZ2dlZfb2ZmKQorCisj
ZGVmaW5lIGZHRU5fVENHX1Y2X3ZzdWJ1aHNhdF9kdihTSE9SVENPREUpIFwKKyAgICBmR0VOX1RD
R19QQUlSX0FERFNVQih1c3N1YiwgTU9fMTYsIFZkZFZfb2ZmLCBWdXVWX29mZiwgVnZ2Vl9vZmYp
CisKKyNkZWZpbmUgZkdFTl9UQ0dfVjZfdnN1YnV3c2F0X2R2KFNIT1JUQ09ERSkgXAorICAgIGZH
RU5fVENHX1BBSVJfQUREU1VCKHVzc3ViLCBNT18zMiwgVmRkVl9vZmYsIFZ1dVZfb2ZmLCBWdnZW
X29mZikKIC8qIFZlY3RvciBzaGlmdCByaWdodCAtIHZhcmlvdXMgZm9ybXMgKi8KICNkZWZpbmUg
ZkdFTl9UQ0dfVjZfdmFzcmgoU0hPUlRDT0RFKSBcCiAgICAgZG8geyBcCi0tIAoyLjM0LjEKCg==

