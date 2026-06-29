Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B18C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 03:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39T-0001cn-UH; Sun, 28 Jun 2026 23:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39R-0001bn-6P
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39P-0006FC-ED
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:16 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2cwDR1527151
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ThmCBEUUn0U8qb4sT7PqDbrtmt1EHLpETdzQjy89vaA=; b=RSX/+RsmwD5sw3Cv
 VmlXh9c8titQ4Ibmir6bbj+KVGdIAp5J7rQ2ZvKowypQd0QNw7co8dRlVz2vCych
 AE5yxrLchcJIxot1IVAM65TVw+c+Qn4jMPQAF+HXVHQrDjtjPKzjFr1AQ+Ie7KQC
 MU4vhLQbu102SFMXyVooMck/0dZ0xDQnrqg8CQ7bBnfcai6LG2ajWUB/c41OpBDN
 YH6WvLRyANmNSevHiTytURT/Bj5F8J+oJyOYznOlxr8Nuu4QoykRfeGLj2YtYgqG
 S7qohswM50g5JGeYnYEXe7p+rMz4p9tscJv8mOGnaunM3eAspLJXd+SQXMd7r8N4
 RSnlYg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27334d01-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:04 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-137f3465368so2930086c88.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705544; x=1783310344; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThmCBEUUn0U8qb4sT7PqDbrtmt1EHLpETdzQjy89vaA=;
 b=K9Y/NPSMtPQptkMDm2MyOcdKS6z2KIHGsxAVHBQsCd97mu+aaR9oaeix5oIzPZKgsz
 C/JjxMiIYkQMuU/5D229ivzPdH9U6+9M78D1WikDxyijVt92lDsrFt46yt2IBf8xNzbF
 3LTUTWckYSvGMLgNW6cLlz9IMBZmiYEPnZW5bG6Oz2voCiMb3yeCA40itkiAgmlQLcCm
 IUU7W7jM3IxR0Zrxd2hiZsP4bOOTw5Xy8TnSsKU2vNaetsI3BLEMR8Cgg/F1pKJ4PMl2
 77e0IyjSvgqP3sVJvHGzTjwyOCrVmmtF8XpBBATB9LfcOmAF3g0aBdedDkiC+KlfaJqd
 thTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705544; x=1783310344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ThmCBEUUn0U8qb4sT7PqDbrtmt1EHLpETdzQjy89vaA=;
 b=IwTVUoYMc348ZS0m1z6ESnNWJCyENQ8V2e5WTKTfjV17ECm4H5o6qaLYdxHfn2NQ+O
 EqrybDE7FqwYBtPOMRbeL/+ozhe2vojjii1pnLx1yOFIsfnZn42tyWWuEzPuLTJeWisM
 p52f/O4Qz3aSLrY3/B/5cxgBfnW3D5D7ImxrIu45uTZ92qT+5Pa4lz0yi4Tt4FBwXAlI
 6ru+IEe4sGotS4n3X0ysYyCNth6c+lzkGwlXIOnVVvlgeDz0lkdNyzxdWsEprJ0A7BtD
 dq+JvWBkBP/J6+WKAPvd+d6iZftNSasj2OWpzwO/F8n/+7S430ZxwoTzg0NMwuEK1SkY
 OUIg==
X-Gm-Message-State: AOJu0YzPrCQAEprydgwSneYu+ULchjWEXsz9aBvCO63oiyjblx4iLJ15
 KB+XVEEkS0NmnVhqUrhTB//wmefqeQWGN5pprYONLD2Y6iDmPJeKbQ97zDQupdd5TVMUCtwFsXs
 otkJv0IgfV2UrE3FhyRFZ6t8izUQ7PeREA4PSQKJYfZk5tEppxbtGqAWQlCsSzVTSzA==
X-Gm-Gg: AfdE7ckSA+065aFY0HvMnGBI5TQCS6Apy0BSxEi/kYkFFDi1hy88jYk1v5QwKGlGJ9D
 DO8y0vvwieNyfjnUaXJ/wW/ZlZkuLF6MIwXKR61zmDsm51HEsKPNeHBzM9/LW74OoCLYRJ1coel
 BjITuNJ6FB2x3fiDUrwlJyy62Et5y+IkOn5QMGjBGtD/EdP7b9QeFYJpIc2P397+2Qo+cqO0Bpe
 vMEDPGdxfajKMvLYlWQsXemSidSw36aZcLA/UrrXnG9aO+u3G7UK3NVsKVYOa3+WM1AjdeHFENd
 KUQoKgVBB/Tu0ylPHCTrtsja+qKpjDr19yBGvc+MpTmNoFowU8RruSQov8fxBL/+H9SavL+Uebk
 xEK/UW8CymM6YW/8oltJfYuuy/jYtKcMjKPdDpIGVvS188kolkp8lQgx9N9U=
X-Received: by 2002:a05:7022:45a2:b0:139:7fd9:a22 with SMTP id
 a92af1059eb24-139dbbc5904mr10820887c88.35.1782705543564; 
 Sun, 28 Jun 2026 20:59:03 -0700 (PDT)
X-Received: by 2002:a05:7022:45a2:b0:139:7fd9:a22 with SMTP id
 a92af1059eb24-139dbbc5904mr10820867c88.35.1782705543037; 
 Sun, 28 Jun 2026 20:59:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:02 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 14/77] target/hexagon: Add guest, system reg number defs
Date: Sun, 28 Jun 2026 20:57:27 -0700
Message-Id: <20260629035830.1520296-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=F+FnsKhN c=1 sm=1 tr=0 ts=6a41ed88 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=tCkOjFGBvLAhDY2OQcYA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: hLV6G4bvdlGLn_DHtPScg3w7zbDccA32
X-Proofpoint-ORIG-GUID: hLV6G4bvdlGLn_DHtPScg3w7zbDccA32
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX2YzZJkrl8w1Y
 J2NPujo6wDGEmjlmGKmcrcM5q7rLUyPhEuoiurHhA438tJJ13/c7B1W/+Q0BN70hVFh6/oP2s35
 30fR6/m0XcLktNYlp7Bdce3nakgWZ6s8DHS/wbg7Fw9aLJcObVpFDT0sK5egr7RqlxHvj3nDAYd
 SUlk8X45TiPq1PDtoTVYU6wV/XxgcOSCw8VyDZvvYjt7o0sW8RK4DQHc1O8lCi1BnRKg+GphQxc
 /fpXhU7qbAmFQhSjfKXOw7esNYwXNzpS7e7JEE8qjsIXtQ2iEc8OxNsEsMFmPW/cNkM+ZkDDTyk
 0ag8l7OSWWFhu9ITV5S84QaHIr9pGXSJDJ0hP8fVzsILtfH54Z1eyqydAT4a06S4mw4/vLimcR6
 C1RcolAixh+/0C6kRRXtpubM+GagQtEeXsp1ABF9QZlOcRBhmVxBXS89t4Ky/e8xUBlxg0r9DSe
 cmbdJ96XJ5l86VANmwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXwi2U1AEhMuCo
 NhUQq6HCxGsYaW421yO0niVPzpS0I48rm+fqw7WuutxW0hX+ouLFf6CyzOFDx5iJvr7T3Hx0mgH
 zLH+D/AAlKMFiz5JJwVMgVBT3zqsNBc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5oICAgICAgfCAgIDcgKysrCiB0YXJnZXQvaGV4YWdvbi9oZXhfcmVncy5oIHwgMTE3ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDEyNCBp
bnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmggYi90YXJnZXQv
aGV4YWdvbi9jcHUuaAppbmRleCBlMjI1NjdkOGU2Ny4uZTBjZjg3ZTVhNGMgMTAwNjQ0Ci0tLSBh
L3RhcmdldC9oZXhhZ29uL2NwdS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCkBAIC0yMCw2
ICsyMCwxMyBAQAogCiAjaW5jbHVkZSAiZnB1L3NvZnRmbG9hdC10eXBlcy5oIgogCisjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkKKyNkZWZpbmUgTlVNX0dSRUdTIDMyCisjZGVmaW5lIEdSRUdfV1JJ
VEVTX01BWCAyCisjZGVmaW5lIE5VTV9TUkVHUyA2NAorI2RlZmluZSBTUkVHX1dSSVRFU19NQVgg
MgorI2VuZGlmCisKICNpbmNsdWRlICJjcHUtcW9tLmgiCiAjaW5jbHVkZSAiZXhlYy9jcHUtY29t
bW9uLmgiCiAjaW5jbHVkZSAiZXhlYy90YXJnZXRfbG9uZy5oIgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vaGV4X3JlZ3MuaCBiL3RhcmdldC9oZXhhZ29uL2hleF9yZWdzLmgKaW5kZXggYmRk
ZmMyODAyMWMuLjIxNGI3YjhmZGU4IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfcmVn
cy5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9yZWdzLmgKQEAgLTgxLDQgKzgxLDEyMSBAQCBl
bnVtIHsKICAgICBIRVhfUkVHX1VUSU1FUkhJICAgICAgICAgID0gNjMsCiB9OwogCisjaWZuZGVm
IENPTkZJR19VU0VSX09OTFkKKworI2RlZmluZSBIRVhfR1JFR19WQUxVRVMgXAorICBERUNMX0hF
WF9HUkVHKEcwLCAgICAgICAgIDApIFwKKyAgREVDTF9IRVhfR1JFRyhHRUxSLCAgICAgICAwKSBc
CisgIERFQ0xfSEVYX0dSRUcoRzEsICAgICAgICAgMSkgXAorICBERUNMX0hFWF9HUkVHKEdTUiwg
ICAgICAgIDEpIFwKKyAgREVDTF9IRVhfR1JFRyhHMiwgICAgICAgICAyKSBcCisgIERFQ0xfSEVY
X0dSRUcoR09TUCwgICAgICAgMikgXAorICBERUNMX0hFWF9HUkVHKEczLCAgICAgICAgIDMpIFwK
KyAgREVDTF9IRVhfR1JFRyhHQkFEVkEsICAgICAzKSBcCisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xF
XzFULCAgMTApIFwKKyAgREVDTF9IRVhfR1JFRyhHQ1lDTEVfMlQsICAxMSkgXAorICBERUNMX0hF
WF9HUkVHKEdDWUNMRV8zVCwgIDEyKSBcCisgIERFQ0xfSEVYX0dSRUcoR0NZQ0xFXzRULCAgMTMp
IFwKKyAgREVDTF9IRVhfR1JFRyhHQ1lDTEVfNVQsICAxNCkgXAorICBERUNMX0hFWF9HUkVHKEdD
WUNMRV82VCwgIDE1KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BNVUNOVDQsICAgMTYpIFwKKyAgREVD
TF9IRVhfR1JFRyhHUE1VQ05UNSwgICAxNykgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQ2LCAg
IDE4KSBcCisgIERFQ0xfSEVYX0dSRUcoR1BNVUNOVDcsICAgMTkpIFwKKyAgREVDTF9IRVhfR1JF
RyhHUENZQ0xFTE8sICAyNCkgXAorICBERUNMX0hFWF9HUkVHKEdQQ1lDTEVISSwgIDI1KSBcCisg
IERFQ0xfSEVYX0dSRUcoR1BNVUNOVDAsICAgMjYpIFwKKyAgREVDTF9IRVhfR1JFRyhHUE1VQ05U
MSwgICAyNykgXAorICBERUNMX0hFWF9HUkVHKEdQTVVDTlQyLCAgIDI4KSBcCisgIERFQ0xfSEVY
X0dSRUcoR1BNVUNOVDMsICAgMjkpIFwKKyAgREVDTF9IRVhfR1JFR19ET05FCisKKyNkZWZpbmUg
REVDTF9IRVhfR1JFR19ET05FCisjZGVmaW5lIERFQ0xfSEVYX0dSRUcobmFtZSwgdmFsKSBIRVhf
R1JFR18gIyNuYW1lID0gdmFsLAorZW51bSBoZXhfZ3JlZyB7CisgICAgSEVYX0dSRUdfVkFMVUVT
Cit9OworI3VuZGVmIERFQ0xfSEVYX0dSRUcKKyN1bmRlZiBERUNMX0hFWF9HUkVHX0RPTkUKKwor
I2RlZmluZSBERUNMX0hFWF9HUkVHX0RPTkUgMAorI2RlZmluZSBERUNMX0hFWF9HUkVHKF8sIHZh
bCkgKDEgPDwgdmFsKSB8CitzdGF0aWMgaW5saW5lIGJvb2wgZ3JlZ19pbXBsZW1lbnRlZChlbnVt
IGhleF9ncmVnIGdyZWcpCit7CisjaWYgTlVNX0dSRUdTID4gMzIKKyNlcnJvciAiTlVNX0dSRUdT
IHRvbyBsYXJnZSBmb3IgZ3JlZ19pbXBsZW1lbnRlZCgpOiB1cGRhdGUgYGltcGxfYml0bWFwYCIK
KyNlbmRpZgorICAgIHN0YXRpYyBpbnQzMl90IGltcGxfYml0bWFwID0gSEVYX0dSRUdfVkFMVUVT
OworICAgIHJldHVybiBpbXBsX2JpdG1hcCAmICgxIDw8IGdyZWcpOworfQorI3VuZGVmIERFQ0xf
SEVYX0dSRUcKKyN1bmRlZiBERUNMX0hFWF9HUkVHX0RPTkUKKworI2VuZGlmIC8qIENPTkZJR19V
U0VSX09OTFkgKi8KKworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitlbnVtIHsKKyAgICBIRVhf
U1JFR19TR1AwID0gMCwKKyAgICBIRVhfU1JFR19TR1AxID0gMSwKKyAgICBIRVhfU1JFR19TVElE
ID0gMiwKKyAgICBIRVhfU1JFR19FTFIgPSAzLAorICAgIEhFWF9TUkVHX0JBRFZBMCA9IDQsCisg
ICAgSEVYX1NSRUdfQkFEVkExID0gNSwKKyAgICBIRVhfU1JFR19TU1IgPSA2LAorICAgIEhFWF9T
UkVHX0NDUiA9IDcsCisgICAgSEVYX1NSRUdfSFRJRCA9IDgsCisgICAgSEVYX1NSRUdfQkFEVkEg
PSA5LAorICAgIEhFWF9TUkVHX0lNQVNLID0gMTAsCisgICAgSEVYX1NSRUdfR0VWQiAgPSAxMSwK
KyAgICBIRVhfU1JFR19HTEJfU1RBUlQgPSAxNiwKKyAgICBIRVhfU1JFR19FVkIgPSAxNiwKKyAg
ICBIRVhfU1JFR19NT0RFQ1RMID0gMTcsCisgICAgSEVYX1NSRUdfU1lTQ0ZHID0gMTgsCisgICAg
SEVYX1NSRUdfSVBFTkRBRCA9IDIwLAorICAgIEhFWF9TUkVHX1ZJRCA9IDIxLAorICAgIEhFWF9T
UkVHX1ZJRDEgPSAyMiwKKyAgICBIRVhfU1JFR19CRVNUV0FJVCA9IDIzLAorICAgIEhFWF9TUkVH
X0lFTCA9IDI0LAorICAgIEhFWF9TUkVHX1NDSEVEQ0ZHID0gMjUsCisgICAgSEVYX1NSRUdfSUFI
TCA9IDI2LAorICAgIEhFWF9TUkVHX0NGR0JBU0UgPSAyNywKKyAgICBIRVhfU1JFR19ESUFHID0g
MjgsCisgICAgSEVYX1NSRUdfUkVWID0gMjksCisgICAgSEVYX1NSRUdfUENZQ0xFTE8gPSAzMCwK
KyAgICBIRVhfU1JFR19QQ1lDTEVISSA9IDMxLAorICAgIEhFWF9TUkVHX0lTREJTVCA9IDMyLAor
ICAgIEhFWF9TUkVHX0lTREJDRkcwID0gMzMsCisgICAgSEVYX1NSRUdfSVNEQkNGRzEgPSAzNCwK
KyAgICBIRVhfU1JFR19MSVZFTE9DSyA9IDM1LAorICAgIEhFWF9TUkVHX0JSS1BUUEMwID0gMzYs
CisgICAgSEVYX1NSRUdfQlJLUFRDRkcwID0gMzcsCisgICAgSEVYX1NSRUdfQlJLUFRQQzEgPSAz
OCwKKyAgICBIRVhfU1JFR19CUktQVENGRzEgPSAzOSwKKyAgICBIRVhfU1JFR19JU0RCTUJYSU4g
PSA0MCwKKyAgICBIRVhfU1JFR19JU0RCTUJYT1VUID0gNDEsCisgICAgSEVYX1NSRUdfSVNEQkVO
ID0gNDIsCisgICAgSEVYX1NSRUdfSVNEQkdQUiA9IDQzLAorICAgIEhFWF9TUkVHX1BNVUNOVDQg
PSA0NCwKKyAgICBIRVhfU1JFR19QTVVDTlQ1ID0gNDUsCisgICAgSEVYX1NSRUdfUE1VQ05UNiA9
IDQ2LAorICAgIEhFWF9TUkVHX1BNVUNOVDcgPSA0NywKKyAgICBIRVhfU1JFR19QTVVDTlQwID0g
NDgsCisgICAgSEVYX1NSRUdfUE1VQ05UMSA9IDQ5LAorICAgIEhFWF9TUkVHX1BNVUNOVDIgPSA1
MCwKKyAgICBIRVhfU1JFR19QTVVDTlQzID0gNTEsCisgICAgSEVYX1NSRUdfUE1VRVZUQ0ZHID0g
NTIsCisgICAgSEVYX1NSRUdfUE1VU1RJRDAgPSA1MywKKyAgICBIRVhfU1JFR19QTVVFVlRDRkcx
ID0gNTQsCisgICAgSEVYX1NSRUdfUE1VU1RJRDEgPSA1NSwKKyAgICBIRVhfU1JFR19USU1FUkxP
ID0gNTYsCisgICAgSEVYX1NSRUdfVElNRVJISSA9IDU3LAorICAgIEhFWF9TUkVHX1BNVUNGRyA9
IDU4LAorICAgIEhFWF9TUkVHX1M1OSA9IDU5LAorICAgIEhFWF9TUkVHX1M2MCA9IDYwLAorICAg
IEhFWF9TUkVHX1M2MSA9IDYxLAorICAgIEhFWF9TUkVHX1M2MiA9IDYyLAorICAgIEhFWF9TUkVH
X1M2MyA9IDYzLAorfTsKKyNlbmRpZiAvKiAhQ09ORklHX1VTRVJfT05MWSAqLworCiAjZW5kaWYK
LS0gCjIuMzQuMQoK

