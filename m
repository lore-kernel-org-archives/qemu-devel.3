Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C172FC79F99
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 20:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2weS-0001Xd-Vt; Sat, 05 Sep 2026 16:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2weQ-0001WQ-5T
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:06:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2weO-000637-ID
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:06:09 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685HbbVi2894506
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 20:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3mn2zD5a/u6Y9t9iPYP/y3REBAZfB3SgTdhFHg8ZHqU=; b=bY1YGYR67SPFSU8y
 nddH6w9wuzzmzq/bJHtjHcgnnxAPeMmJwfE5U8j04XaKMA/OJDaHX+gMMR0bvqPi
 YoRmcDVr8yxptwx75cnM5XTroVSeKQdKY3DZvBhiHGN9W2F/67/Eb3NzSWutV9rq
 vpN/6TcXmXFATl/9moVsnBO9cAcM55aOHBr1g5OVNK4P+SEuTDU7zVsGDpPp8/bk
 517PzzA10cdF+ntA2tNwZMGcm12ppx8mtXryoKuRrpwOFUYMTMc9/rRiPJ7RjGuD
 ahT13dW9c7yfjufCzPucpTL7FZ/lmbCmgEDrkzAlS+cp0ylLKlfh+ONoM9RBS12w
 +o7Drg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggadhj66y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 20:06:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cfa4e4684bso46827055ad.2
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 13:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788638766; x=1789243566; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3mn2zD5a/u6Y9t9iPYP/y3REBAZfB3SgTdhFHg8ZHqU=;
 b=AWBKgdgwAENav/ErbODtkFsdwzsrBd9YUbnlOhJ/ZE2kiunSa/FIi32ZWjSmdSN2g6
 AdFuZgCsketShm49R+OHnNtpsGwCjLnANy5aPgPYfYKcrSZGayyywC2iajWF0QIc9BQQ
 VHtwQdzZv59Uc1ADJV9L/IYmOVUaJuwkElWLR3HB3u/zZ2R1U/obHgcNRYZDx8Jp5kYY
 1uyUQM4cyebFH7ATVONqFQCaOUtEzvXE2y5qizKV7OpXvLe8kItNI7pZ1Y2XTjqofuE6
 X1kb6x7p7V4yrAdq0oh/3NQ8WkSdeEd4xf64gVm7T8RW9dZvl59mRxU6Cf3ve7gWg/98
 44jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788638766; x=1789243566;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3mn2zD5a/u6Y9t9iPYP/y3REBAZfB3SgTdhFHg8ZHqU=;
 b=X+RPSB3RJdNC71nAGxjHnSxz9vdTdhkEvwNjtHEGAsJjOEiRBq12ttGsCvgicS7cUx
 J5jRom2C45xdp3xY7AqjRcjT06L5CXE5XPDW9HWbj+X+m/Gn+IkmFcvHNPA5DQ4+ZfLC
 2skCJizhOX09zPcUJcuOQmems1eys983ZI5USSc/Fr9u+SwLxxWb74XncsK9Sl96AAnV
 efQMEHTFl5yF/SMpgZFFa8vYMZv34Wf4pqc6/7Co1Kq3q2lMcyIKpVQxQ0W5USWDNrMD
 UiHJrJYnEoxabg8J+zviLfXMYprFTMF0yjT/fMN/BJW1SaRSeij71+XNPCKbyURjw3xa
 wBcg==
X-Gm-Message-State: AFuF++mY3vBpwoc/DhfdnkWzl3nfDt2o/BWrcqB1seZJ+89EXl/Lz5r6
 2EYZiRGourJRgPfg3GXj44yh6he3p5RgB5uI0bSp4+fJCrQImAf/Nd4bujA8ufFPvIN/SI5a+M4
 ejIANrWT9DYeW0YpoF/KqYFiBDFYJIPXUqOOCIW2+f2gV91nO13kBv81qU3IPhOTvsA==
X-Gm-Gg: AYBFou0botMu5DwR+4kwK+zSq8kmV8xLsTUKZfZiPKBUB90NixhrbEJdesc4kTQQcon
 nYN5SK1HGJhZeV011sCBtWvcyv2WFPAEfLEb6jUmKrBrP6JCJcQNAzqPopyTJERnprZhV5dyf00
 jksuu/HmgpYHkLX1SHCWBKFu0qecPcQvPTRwzLXbQH/SiEH/j65vnOs5eWTrnBOWAoU1Jsy3Qt2
 JUv8xALm/JBycKus/N9OmiOFh6b+ZGdkay2M8fFQ8w3ht5xj5qUiMWycRfw7qFp3SiJuQk0kD7p
 k0MJn89Gmhp/sm3kSxqKezGQ1XZlAMSmaSFW+7uT+Tp7AlgpeEvcmkd5ABHhnEUNJCUu3EH9zXR
 HpyuUws4CQUJyEkh1YBscaRgZcnY2v0ym1GX6ktE1M4SCiTY8
X-Received: by 2002:a17:903:198e:b0:2d9:383a:30f1 with SMTP id
 d9443c01a7336-2db125ce07cmr236233915ad.4.1788638766550; 
 Sat, 05 Sep 2026 13:06:06 -0700 (PDT)
X-Received: by 2002:a17:903:198e:b0:2d9:383a:30f1 with SMTP id
 d9443c01a7336-2db125ce07cmr236233275ad.4.1788638766170; 
 Sat, 05 Sep 2026 13:06:06 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339bbebf2fsm17346075eec.25.2026.09.05.13.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 13:06:04 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 8/9] tests/functional/hexagon: update arch tests to v0.2.14
Date: Sat,  5 Sep 2026 13:05:49 -0700
Message-Id: <20260905200550.2009799-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
References: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: hSxnjqhyyMxlQzEbACG8vfUH5-NY2_t6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIyMyBTYWx0ZWRfXw64R1QJfcwaa
 nmdtM/95YOtOBNCKjhsjTmCzZre3V8pdtqVMn7fKutVp4170rw1OHX0q2WCwGKxyRHvsYrbUnGO
 ttNYl+5y++dB7ZeMX7SgHFYdfyrBv159QBpgm0vbe5lmfp1/8AdUMTfgBsDVwdJfa1+E+68xU/L
 6NM4doR42YGqEXC73RtXBODlQBPxVtJUatybe5yKC0TUXkpJ76CrUv5hUPHb4X34n7R6VM/6DTh
 rVe65eZQbAJk9EDjJJeJshoM8VJQ2XzNS3PWIerUcKBI3AFce9Blxtd6oIiPvTSquiKI+kzsYIE
 ElHPu+8DHUMvYVCFMdZuq+8hWB1nWwp3rgKnZH59e5FyZRmF0vsGO7/w6+W42ohwNszlbCtCdYx
 IeypguCjxE8e2EGrGxYn6nMZ0Lhzg18jqfaNIvFmaDVDgE4AuedqhDd/Xqpt9AtsSoO34Hynrrt
 rTDxpJL6liOqPQXiQEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIyMyBTYWx0ZWRfX6WF+0b+D6Mpy
 g7Lpj6MvTgSG0YeqqVSZu9o1Eip/tH4VC+m1VetBOcm9z/lVXeR/wL9eB1FrLDF52FZREjPE7y9
 U4YrZJia+Uu4aUBQBxD7/B95XTzJNlw=
X-Authority-Analysis: v=2.4 cv=OceoyBTY c=1 sm=1 tr=0 ts=6a9c762f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=EqftbGKkiOAk-SFv07wA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: hSxnjqhyyMxlQzEbACG8vfUH5-NY2_t6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609050223
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

U29tZSBvZiB0aGUgdGVzdHMgcnVuIGxvbmdlciBub3csIGV4dGVuZCB0aGUgdGltZW91dCB0byAx
ODBzCmluIG9yZGVyIHRvIGtlZXAgaXQgcm9idXN0LgoKUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJv
dXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTog
QnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRlc3RzL2Z1bmN0
aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9m
dW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5IGIvdGVzdHMvZnVuY3Rpb25hbC9o
ZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weQppbmRleCA4ZTcxMzg2YzE4Ni4uNWQ3Y2U0ODc0MzYg
MTAwNzU1Ci0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkK
KysrIGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weQpAQCAtMTcs
MTIgKzE3LDEyIEBAIGNsYXNzIEFyY2hUZXN0c1VhcnQoUWVtdVN5c3RlbVRlc3QpOgogCiAgICAg
VGVzdHMgb3V0cHV0IHJlc3VsdHMgdmlhIFVBUlQuCiAgICAgIiIiCi0gICAgdGltZW91dCA9IDYw
CisgICAgdGltZW91dCA9IDE4MAogCiAgICAgQVNTRVRfVEFSQkFMTCA9IEFzc2V0KAogICAgICAg
ICAiaHR0cHM6Ly9naXRodWIuY29tL3F1YWxjb21tL3FlbXUtaGV4YWdvbi10ZXN0aW5nL3JlbGVh
c2VzLyIKLSAgICAgICAgImRvd25sb2FkL3YwLjIuMTIvYXJjaF90ZXN0c191YXJ0LnRhci5neiIs
Ci0gICAgICAgICI4NzFhMzM5YmY3OGNhYzBlYmFmMWIyNTA5YmZjZDViMjQ5YWQ4MTkwYmUzM2Uw
Y2Y4NDgyODNiMmY2OTE1MzIzIiwKKyAgICAgICAgImRvd25sb2FkL3YwLjIuMTQvYXJjaF90ZXN0
c191YXJ0LnRhci5neiIsCisgICAgICAgICJjZTkzY2I5MGI5ZDc1N2MxOTQ2ZGZlOGZlNmFiY2Vj
ODI5MmIwOGE2NjU0NmFjNTFiMmRkNDg2NTBiMDVmYTkxIiwKICAgICApCiAKICAgICBkZWYgcnVu
X3VhcnRfdGVzdChzZWxmLCB0ZXN0X25hbWU6IHN0ciwKLS0gCjIuMzQuMQoK

