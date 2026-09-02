Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0370CC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1coi-0000HU-6t; Wed, 02 Sep 2026 00:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1coe-0000En-Di
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1cob-0000Lr-MW
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:15 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6824C68c2983309
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mcEDKaXk/V4durGYugyVdvHkcGTvG/CoUwinf9Jtyf0=; b=iSiSuYpshJnHJibG
 nOhwmlKR9DBWRCoDmGV4/TRzJb5juyepq5FS2cClJPfZ0f7ih6ArbSkx6ZL8jw8b
 CgCRn5oA+OyyJ5XnUvTJhb7fa6XHA7BKO5NafWUg2h7ln7JFUxR5EAuk1UjdIeOJ
 +mZbUXSAX0I+Xsdtxu1DDlYZxAsFdJbS4z80hwDiDUhY5qFRgJatGqwi1jHNpQUn
 Oo9SwWdKts5ju+A+P0yi9ILzLaPQcxlEyc14MP8oq9jxWk2LAmKEUqXwB2k/PSgJ
 /QFepVNUDlJ3q1hg2M5UTNQN2hI8kjMLCHVASv+nJYHS9Ut1sZRojm1vDXh5evN9
 2xFxfQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge35k25sp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:43:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38f283baf1fso885984a91.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324181; x=1788928981; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mcEDKaXk/V4durGYugyVdvHkcGTvG/CoUwinf9Jtyf0=;
 b=aWW//Svo6PakbOvldA52na/ksm73MQI1m39xl+xSyCs8oMVNa0mOv3kfkjmwTzauH9
 ts2BvbFFpEoryI/LdK7pcrWFZ1NCMa/Hn3o3TpiMPE62pwbqUVn44moPPMG1e2fulmpS
 GjtuEphIS+SuB8CJzYGEVmt9Gh/Da7a0RGMqnkBmyn1748uYT4DL2MNk240gTypU17tr
 AE1KnO/rSiTERcmaCCD04fD0nhR0287KLLLi2tqdiPqUHBUzg/z1GvJlNaNYI/4a8nYp
 vpJE8z8YyE5YBsAebYTw7RkimpznJVFBkIj+FInzjL+SKbAIVpe0+KDJoIMjBuevMuJt
 DI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324181; x=1788928981;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mcEDKaXk/V4durGYugyVdvHkcGTvG/CoUwinf9Jtyf0=;
 b=WIylgFjjJp4f9r+k4f3WPgBHcpavdrpockm4wVKplYLKFcEdYEq6BLVlzcffeOnHOY
 O9AntdCt2jvauUZYmvUyD1czDXfZtzXyA7wMI3kJ6LO7Qgt93fXrqYy17f0XBvZD/EBu
 fhfU2voZZ7glyrwugIMOhz68ZRZXWl7Qnkfa0jwZd8SXgAb14jhx7RpJzj5Jo3knUen3
 CnKNNiadxnitva4H7HJpdQHojEXsBbRTmb633dqsdznH/h8+ijAyoW+e2L+TFD/YbEgB
 wDGw8qhuiSZJgrHljQosIsu8zbDG+wOFVBdHqYV+pROx6IqtCutECc+Vi1jHBPo+a01N
 Osog==
X-Gm-Message-State: AFuF++lH6sYz4KpOGXdUoPI6UDFS5eYezFXuP7D9d5WtozpDYrHiHPaK
 FH013oGPyUD4CbJNZw1rxAOyGvQ8sa/p1HeE1bUTW15N8Dw2ecxRCqmIHpXscb/wz0DTW05eG7+
 PCx/0yaBmizMI4WRIP5gnSbv11xKhtNF9mvRf+t258BCz73zivzfvU2JqxxDQCmDd4A==
X-Gm-Gg: AYBFou2uvNuIKPwy9N88TRlE2XeRchRH+LQQCrs0pHw/XW5KhGESsXgASJcxKXUnYvf
 8ucwKWsJAJEJQASzNH7PaDQYG0k5gAuNpqex1c9pNE0ETgh4L7h3E3UAyHpDx40c0e8uuw4J0uu
 /ckgfLOCyGowjUMxb5tJ5fm69o9eYBnEsgAyMoaS38fKurBMJXNjGxzW9pGAhEhmJI4yC5shXoo
 G/z9URFFhUgTfCfVKRVxBevqr/XH6bUD8KNiBfkW9mK+O+r5Cj4BxVo6g1QJJAWcYpdXEihZiPh
 TDsIbj1eoEfayKR8Gs1AhdHrOwdFyMCEOq/9X8vZZl9Sx8VgYxDVSFhv0tVihuYJzhP4Hv0OQAs
 mzG/fcrlErYj3rcti8z8nmYE9xpV58YUq7yZT3hHlaX6AcHSj
X-Received: by 2002:a17:90b:3f84:b0:381:25ce:bcc2 with SMTP id
 98e67ed59e1d1-39aedf1922dmr3173056a91.6.1788324181414; 
 Tue, 01 Sep 2026 21:43:01 -0700 (PDT)
X-Received: by 2002:a17:90b:3f84:b0:381:25ce:bcc2 with SMTP id
 98e67ed59e1d1-39aedf1922dmr3173001a91.6.1788324180870; 
 Tue, 01 Sep 2026 21:43:00 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:43:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Subject: [PULL 13/28] tests/functional: Add hexagon semihosting systests
Date: Tue,  1 Sep 2026 21:42:16 -0700
Message-Id: <20260902044231.843004-14-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX4xJbMP73b9kc
 s26j6UYH6jxIdW5Dr7nowRrpufPBhkB+xmDK8DltZs3xGwxhml+90zLfFAsp50U7jqQvWjbg8sr
 LWE2Aao14nKGrktPo6wYg2iGfTv/J5P1Up82u0iMY2J8xhJOD6G7LlL2sj7CiClmAOS6Kic3wQC
 4a+u68q3VZGXkKnZLZoiYttj5KzT5MXChKPoKozky4sQ5xukD8ApSPkJw4trzC6KRneQ9T/KVEo
 ybC53xX/YgqHKHEr/5dxLbUe7DST8/pZ8mJIe8tQ0AqLeCCbS9H9ULClsMbD6lxGcTSgzeSLLMR
 kPJTEmas+huFj74tCpjRtG1mLsUF/maBOYSmV5LKSl+z4k8r0ZF8N/cD+4pkdH7Z8O00q7hP8zX
 FcepmI5MVUHvqxbzBBjbA2Or6Q8Y83C2DgGzunRNoaO/tBJTRwd25gTIlPIUrPu3fO0Tn6iEZZd
 9P0651uTAV7FRkKuelg==
X-Proofpoint-GUID: 2-Kjx6ePlTsjz_i0XZirn3w6HZmF4NPC
X-Proofpoint-ORIG-GUID: 2-Kjx6ePlTsjz_i0XZirn3w6HZmF4NPC
X-Authority-Analysis: v=2.4 cv=VLrtWdPX c=1 sm=1 tr=0 ts=6a97a956 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=gC5wIKLFQIU-z-kLmxwA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX2GD8M2TxiYcL
 TyIoKGFBrUPujq//s60SlXJqPlDYx45/n/dT37LBfp8WSSBLiVa6cMaTx74wPsOIlRyU7evqFHB
 v+UqdUR/XFXvgPLsiuJ7hRx9rsy5uhg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020040
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPG1hdGhl
dXMuYmVybmFyZGlub0Bvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWlu
IDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGVzdHMvZnVuY3Rpb25hbC9oZXhh
Z29uL21lc29uLmJ1aWxkICAgICAgfCAgNSArKwogdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rl
c3Rfc3lzdGVzdHMucHkgfCA5NCArKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFu
Z2VkLCA5OSBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAxMDA3NTUgdGVzdHMvZnVuY3Rpb25h
bC9oZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKCmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFs
L2hleGFnb24vbWVzb24uYnVpbGQgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vbWVzb24uYnVp
bGQKaW5kZXggMmI1YTFhOGYyNjQuLjQ0MDUzZTY0Njc2IDEwMDY0NAotLS0gYS90ZXN0cy9mdW5j
dGlvbmFsL2hleGFnb24vbWVzb24uYnVpbGQKKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29u
L21lc29uLmJ1aWxkCkBAIC0yLDQgKzIsOSBAQAogCiB0ZXN0c19oZXhhZ29uX3N5c3RlbV90aG9y
b3VnaCA9IFsKICAgJ2FyY2hfdGVzdHMnLAorICAnc3lzdGVzdHMnLAogXQorCit0ZXN0X2hleGFn
b25fdGltZW91dHMgPSB7CisgICdzeXN0ZXN0cyc6IDE4MCwKK30KZGlmZiAtLWdpdCBhL3Rlc3Rz
L2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5IGIvdGVzdHMvZnVuY3Rpb25hbC9o
ZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKbmV3IGZpbGUgbW9kZSAxMDA3NTUKaW5kZXggMDAwMDAw
MDAwMDAuLmYzNmUwMTVmNTAyCi0tLSAvZGV2L251bGwKKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9o
ZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkKQEAgLTAsMCArMSw5NCBAQAorIyEvdXNyL2Jpbi9lbnYg
cHl0aG9uMworIworIyBDb3B5cmlnaHQoYykgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIElu
Yy4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4KKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjAtb3ItbGF0ZXIKKworaW1wb3J0IG9zCitpbXBvcnQgcmUKK2ltcG9ydCB0aW1lCitpbXBvcnQg
dW5pdHRlc3QKKworZnJvbSBxZW11X3Rlc3QgaW1wb3J0IFFlbXVTeXN0ZW1UZXN0LCBBc3NldCwg
d2FpdF9mb3JfY29uc29sZV9wYXR0ZXJuCisKKworX1RBUkJBTExfQklOX1BBVEggPSAoCisgICAg
InN5c3Rlc3RzX3N0YW5kYWxvbmVfcGFja2FnZSIsCisgICAgIlN0YW5kYWxvbmVTeXNUZXN0c182
LjQuMC4yX3Y2OCIsCisgICAgImJpbiIsCispCisKK2NsYXNzIFN5c1Rlc3RzU3RhbmRhbG9uZVRl
c3RzKFFlbXVTeXN0ZW1UZXN0KToKKyAgICBTWVNURVNUX1RJTUVPVVRfU0VDID0gMzAKKworICAg
IEFTU0VUX1RBUkJBTEwgPSBBc3NldCgKKyAgICAgICAgImh0dHBzOi8vZ2l0aHViLmNvbS9xdWFs
Y29tbS9xZW11LWhleGFnb24tdGVzdGluZy9yZWxlYXNlcy9kb3dubG9hZC92MC4yLjExL3N5c3Rl
c3RzX3N0YW5kYWxvbmUudGFyLmd6IiwKKyAgICAgICAgImI1Nzc3YWE2NTI0NWRlNzcxMGE3YTA4
ZDcxNzk1M2MxMzYyYmU3YzhiNjBkOTAxNGM5ZmVlOGIxNzYxMGFkMWMiLAorICAgICkKKworICAg
IGRlZiBzZXRVcChzZWxmKToKKyAgICAgICAgc3VwZXIoKS5zZXRVcCgpCisgICAgICAgIHNlbGYu
YXJjaGl2ZV9leHRyYWN0KHNlbGYuQVNTRVRfVEFSQkFMTCkKKworICAgIGRlZiBiaW5hcnkoc2Vs
ZiwgbmFtZSk6CisgICAgICAgIHBhdGggPSBzZWxmLnNjcmF0Y2hfZmlsZSgqX1RBUkJBTExfQklO
X1BBVEgsIG5hbWUpCisgICAgICAgIHNlbGYuYXNzZXJ0VHJ1ZShvcy5wYXRoLmV4aXN0cyhwYXRo
KSkKKyAgICAgICAgcmV0dXJuIHBhdGgKKworICAgIGRlZiBydW5fZXhpdF96ZXJvKHNlbGYsIGJp
bmFyeV9uYW1lLCAqZXh0cmFfYXJncywgbWFjaGluZT0iVjY2R18xMDI0Iik6CisgICAgICAgIHNl
bGYuc2V0X21hY2hpbmUobWFjaGluZSkKKyAgICAgICAgc2VsZi5zZXRfdm1fYXJnKCItZGlzcGxh
eSIsICJub25lIikKKyAgICAgICAgc2VsZi5zZXRfdm1fYXJnKCIta2VybmVsIiwgc2VsZi5iaW5h
cnkoYmluYXJ5X25hbWUpKQorICAgICAgICBmb3IgZmxhZywgdmFsdWUgaW4gemlwKGV4dHJhX2Fy
Z3NbOjoyXSwgZXh0cmFfYXJnc1sxOjoyXSk6CisgICAgICAgICAgICBzZWxmLnNldF92bV9hcmco
ZmxhZywgdmFsdWUpCisgICAgICAgIHNlbGYudm0ubGF1bmNoKCkKKyAgICAgICAgc2VsZi52bS53
YWl0KHRpbWVvdXQ9NjAuMCkKKyAgICAgICAgc2VsZi5hc3NlcnRFcXVhbChzZWxmLnZtLmV4aXRj
b2RlKCksIDAsCisgICAgICAgICAgICAgICAgICAgICAgICAgZiJUZXN0IHtiaW5hcnlfbmFtZX0g
ZXhpdGVkIHdpdGggIgorICAgICAgICAgICAgICAgICAgICAgICAgIGYiY29kZSB7c2VsZi52bS5l
eGl0Y29kZSgpfSwgZXhwZWN0ZWQgMCIpCisKKyAgICBkZWYgcnVuX2NvbnNvbGVfcGF0dGVybihz
ZWxmLCBiaW5hcnlfbmFtZSwgcGF0dGVybiwgKmV4dHJhX2FyZ3MsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgbWFjaGluZT0iVjY2R18xMDI0Iik6CisgICAgICAgIHNlbGYuc2V0X21hY2hp
bmUobWFjaGluZSkKKyAgICAgICAgc2VsZi5zZXRfdm1fYXJnKCItZGlzcGxheSIsICJub25lIikK
KyAgICAgICAgc2VsZi5zZXRfdm1fYXJnKCIta2VybmVsIiwgc2VsZi5iaW5hcnkoYmluYXJ5X25h
bWUpKQorICAgICAgICBmb3IgZmxhZywgdmFsdWUgaW4gemlwKGV4dHJhX2FyZ3NbOjoyXSwgZXh0
cmFfYXJnc1sxOjoyXSk6CisgICAgICAgICAgICBzZWxmLnNldF92bV9hcmcoZmxhZywgdmFsdWUp
CisgICAgICAgIHNlbGYudm0uc2V0X2NvbnNvbGUoc2VtaWhvc3Rpbmc9VHJ1ZSkKKyAgICAgICAg
c2VsZi52bS5sYXVuY2goKQorICAgICAgICB0cnk6CisgICAgICAgICAgICB3YWl0X2Zvcl9jb25z
b2xlX3BhdHRlcm4oc2VsZiwgcGF0dGVybikKKyAgICAgICAgZmluYWxseToKKyAgICAgICAgICAg
IHNlbGYudm0ua2lsbCgpCisKKyAgICBkZWYgdGVzdF9mb3BlbihzZWxmKToKKyAgICAgICAgIiIi
Zm9wZW4gcmVhZHMgYSBmaWxlIHBhc3NlZCB2aWEgLS1hcHBlbmQgYW5kIHZlcmlmaWVzIGl0cyBj
b250ZW50cy4iIiIKKyAgICAgICAgaW1wb3J0IHRlbXBmaWxlCisgICAgICAgICMgVGhlIGZvcGVu
IGJpbmFyeSBoYXMgYSBzaG9ydCBjbWRsaW5lIGJ1ZmZlcjsgdXNlIGEgc2hvcnQgcGF0aC4KKyAg
ICAgICAgZHVtbXkgPSBvcy5wYXRoLmpvaW4odGVtcGZpbGUuZ2V0dGVtcGRpcigpLCAicWVtdV9m
b3Blbl90ZXN0LnNvIikKKyAgICAgICAgd2l0aCBvcGVuKGR1bW15LCAidyIpIGFzIGY6CisgICAg
ICAgICAgICBmLndyaXRlKCJ2YWxpZFxuIikKKyAgICAgICAgc2VsZi5ydW5fZXhpdF96ZXJvKCJm
b3BlbiIsICItYXBwZW5kIiwgZHVtbXkpCisKKyAgICBkZWYgdGVzdF9mdHJ1bmMoc2VsZik6Cisg
ICAgICAgICIiImZ0cnVuYyB0cnVuY2F0ZXMgX3Rlc3RmaWxlX2Z0cnVuYyBmcm9tIDYgYnl0ZXMg
dG8gMSBieXRlLiIiIgorICAgICAgICBmdHJ1bmNfcGF0aCA9IHNlbGYuc2NyYXRjaF9maWxlKCJf
dGVzdGZpbGVfZnRydW5jIikKKyAgICAgICAgd2l0aCBvcGVuKGZ0cnVuY19wYXRoLCAidyIpIGFz
IGY6CisgICAgICAgICAgICBmLndyaXRlKCJ2YWxpZFxuIikKKyAgICAgICAgIyBTbGVlcCAxIHMg
c28gbXRpbWUgY2hhbmdlIGlzIG9ic2VydmFibGUKKyAgICAgICAgdGltZS5zbGVlcCgxKQorICAg
ICAgICBzZWxmLnJ1bl9leGl0X3plcm8oImZ0cnVuYyIsICItYXBwZW5kIiwgZnRydW5jX3BhdGgp
CisgICAgICAgIHNlbGYuYXNzZXJ0RXF1YWwob3MucGF0aC5nZXRzaXplKGZ0cnVuY19wYXRoKSwg
MSwKKyAgICAgICAgICAgICAgICAgICAgICAgICAiX3Rlc3RmaWxlX2Z0cnVuYyBzaG91bGQgYmUg
MSBieXRlIGFmdGVyIGZ0cnVuYyIpCisKKyAgICBkZWYgdGVzdF9hY2Nlc3Moc2VsZik6CisgICAg
ICAgICIiImFjY2VzcyBjaGVja3MgUl9PS3xXX09LIG9uIF90ZXN0ZmlsZV9hY2Nlc3MuIiIiCisg
ICAgICAgIHRlc3RmaWxlID0gc2VsZi5zY3JhdGNoX2ZpbGUoIl90ZXN0ZmlsZV9hY2Nlc3MiKQor
ICAgICAgICB3aXRoIG9wZW4odGVzdGZpbGUsICJ3IikgYXMgZjoKKyAgICAgICAgICAgIGYud3Jp
dGUoInZhbGlkXG4iKQorICAgICAgICBzZWxmLnJ1bl9leGl0X3plcm8oImFjY2VzcyIsICItYXBw
ZW5kIiwgdGVzdGZpbGUpCisKKyAgICBkZWYgdGVzdF9zZW1paG9zdChzZWxmKToKKyAgICAgICAg
c2VsZi5ydW5fY29uc29sZV9wYXR0ZXJuKCJzZW1paG9zdCIsICJQQVNTIiwgIi1hcHBlbmQiLCAi
YXJnMSIsICJhcmcyIikKKworaWYgX19uYW1lX18gPT0gIl9fbWFpbl9fIjoKKyAgICBRZW11U3lz
dGVtVGVzdC5tYWluKCkKLS0gCjIuMzQuMQoK

