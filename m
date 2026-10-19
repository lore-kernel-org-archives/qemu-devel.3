Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149C6CCF2D3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 06:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIgYi-0004dr-Q0; Mon, 19 Oct 2026 02:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgYh-0004de-BV
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 02:09:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgYf-0002jb-H0
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 02:09:19 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J4j1BK1177593
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 06:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=lFJf0CRO1F9v118CNA76gu
 dUjPj/urH6NqPBh+75yvk=; b=U4o8VxP6xfHDzXM9xrltN63qMJsx+eWL2EG3g6
 EaYIlR3aORZed3fyrYP51pT6OKUDnlxnzJA4rKqiMobDQKD5AZOFo620lr2jPysf
 WSfr3wZoGLgh0R4JTK0O/wZzf+lTX3mhHsAPHKvxMVJbwCw63iYPUaSvJlZ1vLaV
 QpCtfI4kJxegXqJwdhCeK+ClEoQKOIrNGOqSIHdSPZItGCKIcdEmTMOMETDSsLqf
 tcd/hnNUwhsPcL+qbD23IWTBbFd/bjwKNSN7eQ9m4Ehrt20D+rbHMbeASRJk9F/O
 uqD1fdic3znuP3Aq+nGvINgBvHhyl9DVuBaRzhjtSxYnhmPA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc1se51fn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 06:09:14 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso3907019eec.1
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 23:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792390154; x=1792994954; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lFJf0CRO1F9v118CNA76gudUjPj/urH6NqPBh+75yvk=;
 b=B3IVNtNuPgTYiRDo8Ev8itAdOnMHsHQpcQ2HGOFcU8TncZ+OCnYJncu4cYpiHzy9Pa
 jHKJCI27GTfLc0fZztFWZ+CRy+HgBlcxK7dIryUf/XuRXwmi1VKvfbiFDJNGSMco6w+C
 HUC3sunVS5c/KM6iaUbFn+9O/5I3Osiw+uHi2oXdfGyQpofOJ/IK7JoFAqC8y9RWmLcw
 gzdXBur+nk8/IYVJlrcYK1BqFV1JcWqbGdkM/3hhmGpuEdsp6arN5kKGVKG++xMcBPPj
 pyozotVRck13iQacqqsjnGS9TZ1XDDIXgf12/4a6F92xqYEFvp/gRCC7It4ayE+JcIA1
 Dc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792390154; x=1792994954;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lFJf0CRO1F9v118CNA76gudUjPj/urH6NqPBh+75yvk=;
 b=FP0fZDVGOnSlO7MUiM1VOt1r2RcqcgcluJHJlV9WTs/5VJWYC3LufX+U/xlQWwuaqT
 eG0UiEOoNwhae4OO7PU03zhk9Fi9q3raQijWWZfOhHE2dkxcSglNl6q1KC5prYgApAxR
 eoCtFpIWLZsdOLtZibybvo/wiocgeepmriMv1uGn4B6/x5F+3jbVv5p/BUeqGFVFZf3b
 oITjR/KB4BcgnPd3Z+0lDpNypeqZzMwtCl+eoG1Tp0rXIYnIdR1tYiyKkqNnlNivj2o5
 zjQhr4xzcd43Z6ehTcMdIX7G/XMl+mK7J9v8Qzdobss5H3vtYhdvhQJ+bbpADWKrzxZv
 pW+w==
X-Gm-Message-State: AFq9FYLwaDhZyvlZ20GXsuIU/f9Af7/sv/D8fJ3HFRw47/aMPecKTVKT
 +IGD+wmoc2f8bsCJPO0zaand7k3r8Qi+UG2lMtRg801Y0E6yitfTlz/eY+gwhu1XeiKYCV7Zzuy
 9vUznGX1lvaLE0LMcSUrozULLAQisO1R1sfw7jivdEE/qhhdlMzZrM3vZZY2A6biwCA==
X-Gm-Gg: AYBFou0HGUSKUz7VrogBBAHwa2aTerpBj/gCAULqN5D8MBrpoO44ilwWZGiK+Uc2eEd
 rZq0RisFjEXZmADM5A38nLisN0iY36eAEr2s9nPtj4XI5abZFU7Ms2ksLIyWglB4HwRVS+8bZ0z
 GK7wOPfUBLCAbg550qxND5+/5TEPau6zs5x2mRVHnxGZtSk0rp3+k5qrtENlzAR8+K7rI3v8n/P
 MetbYwsEFeUiSAp7RjzHG2Pkw3HgCuOp4FE04XbE5yJWwyI1R72j1lAkdoLEKPnRYW/BTHeRKU2
 3OX/ZE7hty3NAKu9Y/qYwQTenS5WhPOfJvWu00n+J+o3PLdGlSm0Yu/0F5hcIJkXLXwV+eocv0V
 wjhh/pfTi+DnSbBNnJdjC21sn6Llghkwc6CBuxPMSEVu5VvI=
X-Received: by 2002:a05:7022:b881:b0:153:7a27:b89 with SMTP id
 a92af1059eb24-185139aa881mr9258420c88.21.1792390153631; 
 Sun, 18 Oct 2026 23:09:13 -0700 (PDT)
X-Received: by 2002:a05:7022:b881:b0:153:7a27:b89 with SMTP id
 a92af1059eb24-185139aa881mr9258394c88.21.1792390153009; 
 Sun, 18 Oct 2026 23:09:13 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360820a02b8sm31770053eec.17.2026.10.18.23.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 23:09:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH 0/5] Hexagon: enable MTTCG
Date: Sun, 18 Oct 2026 23:09:06 -0700
Message-Id: <20261019060911.1479329-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 7cgrQ6UPSQFO9HB7uJgaykwVOTlymGP4
X-Authority-Analysis: v=2.4 cv=A4z5rKWG c=1 sm=1 tr=0 ts=6ad5b40a cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_Er9LYEKZw53Lbgo3aQA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: 7cgrQ6UPSQFO9HB7uJgaykwVOTlymGP4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfX1DTgmB3w98IA
 fUoC8PUeQ7z3avcrPZTxoYDaBEQdEde6jNUNCayYlIqOQwvoF/xU/XQnNd9uRJlS76Dn7wrZoKg
 0+V3H5hsuYzRzp+m/yllfg8aBoG4zqc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyNCBTYWx0ZWRfX7Z6bvwuXxKos
 FQFb8OLsyyTtYp+uBKEEmKI8HvnpSc6D0SiB++QTVY8SjVyulqcaNp4x7xgLDxOvhusK9tR5Rfi
 9m7vChoeHG0s4ojVZPTR7qVRvphZLw+pOwzIPAPXHb2mQbtTqAsDeClr9WdlBrfT38+gGpQRMLJ
 OSgUks+IDiYb/HnaECv1NyAoj8fucetOftLVlnvp2yIYScWECMjnoRLzvkJg+BN8S34HJ/N5nke
 47tJoMvrYDDM30Aj/hENqsDphGIFJsa8639D+AwTrW+CuJVNPowbnCuYx/tffKkHG94sa4Egfqb
 BD1L9VdvjRvuZwI4HhuLSGeGQEKpFekS9thFqyFtwEcA3r+wXOUXCFKScwVjU1Ysud2axcyttX0
 ljSFWhj30lC4//VQPdjXDOb0IuOgEgLAISemQjYD63FXLxqnkuCe+QDS7RrkT/eiu6PLE5nE28d
 PECBuj0TUvLUa06kmCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190024
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

VHVybmluZyBvbiBtdHRjZyBleHBvc2VkIHNvbWUgYnVncywgdGhlIGZpeGVzIGZvciB0aG9zZSBh
cmUgaW5jbHVkZWQgaW4gdGhpcwpzZXJpZXMuCgpBIHByZXZpb3VzIHNlcmllcyAoc2luY2UgbGFu
ZGVkKSBhbHNvIHByb3ZpZGVkIHNvbWUgZml4ZXMgZm9yClRMQi9iYXJyaWVycy9MTC1TQzogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDkyNzAyNDM0Ny4zNTQ1Mzg1LTEt
YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tLwoKQnJpYW4gQ2FpbiAoNSk6CiAgdGFyZ2V0L2hl
eGFnb246IGFjcXVpcmUgQlFMIGJlZm9yZSByZWFkaW5nIGludGVycnVwdCBzdGF0ZQogIHRhcmdl
dC9oZXhhZ29uOiBjaGVjayBleGNlcHRpb25faW5kZXggaW4gaGFzX3dvcmsKICB0YXJnZXQvaGV4
YWdvbjogZHJvcCBhIHBlbmRpbmcgSEFMVCB3aGVuIHJlc3VtaW5nCiAgaHcvaW50YzogY2lhZCBz
aG91bGQgZm9yd2FyZCBpdHMgbWFzayB0byBsMnZpYwogIHRhcmdldC9oZXhhZ29uOiBlbmFibGUg
TVRUQ0cgZm9yIHN5c3RlbSBlbXVsYXRpb24KCiBjb25maWdzL3RhcmdldHMvaGV4YWdvbi1zb2Z0
bW11Lm1hayB8ICAxICsKIGluY2x1ZGUvaHcvaW50Yy9oZXgtbDJ2aWMuaCAgICAgICAgIHwgMTQg
KysrKysrKysrKy0tLS0KIGh3L2ludGMvaGV4LWwydmljLmMgICAgICAgICAgICAgICAgIHwgMTAg
KysrKysrKy0tLQogdGFyZ2V0L2hleGFnb24vY3B1LmMgICAgICAgICAgICAgICAgfCAgNiArKysr
LS0KIHRhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuYyAgICAgICAgIHwgIDEgKwogdGFyZ2V0L2hl
eGFnb24vaGV4X2ludGVycnVwdHMuYyAgICAgfCAgOCArKysrKy0tLQogdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMgICAgICAgICAgfCAxNCArKysrKysrKystLS0tLQogNyBmaWxlcyBjaGFuZ2Vk
LCAzNyBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkKCi0tIAoyLjM0LjEKCg==

