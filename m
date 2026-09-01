Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB21C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SNG-0005dJ-6U; Tue, 01 Sep 2026 13:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1SNE-0005cc-Jy
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:34:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1SNC-00083K-DH
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:34:15 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681H5pmd119286
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 17:34:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3zPNMVE0OJOjrANZMwm8oXffR5wrlrrxJ1gjkFPtpLc=; b=ScaQCbxyy6zoVcT6
 7nwaBF/k1j0ZS7zSqKLxIydcPGjFR4m+r2BBl9N/JCM9wxK3M6/FdyfGQdjRTfb8
 XNtCKvVPfU+GgGB/4D5qc7NK5eHyImEDnGujETojD9T303uWIvUh+kuGKfqf+2wS
 TXN5/Sk20vEF+GX1tv48CAGvej0myMUf0LPjQb7ZE658Xn+M/mGHJMPZADODN0O5
 KQ4U2qaVc2tDzaCKPFC7wUcrG9weChwFSKPVEJDReGAU93u1nE0Myq7Q/HYt/4Ir
 CpYOLlN4TsUkDJtlkSG3xl/CaBVB8EtOKEDYLAW+UguCttcA/3+oicIwmgBffWWT
 fU0vvA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdsnu35ru-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 17:34:10 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so108225a91.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 10:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788284050; x=1788888850; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3zPNMVE0OJOjrANZMwm8oXffR5wrlrrxJ1gjkFPtpLc=;
 b=MWSVDDJpikCtqf9KQb7sbHCiKec9dTkoGgjahbWsTty3pFP0ocpXnMN49eyF+L8Y6m
 uk/v5Z3KazVFZvfJ+SB858+wRWjgsin8uFqzFoUgU58JCG7tlyNvVmgrQbi+2XUkZ1rf
 2AaJ4SRYouS+N3LQPXNRy3vfzHQHEo7Zb/IQCTKuOLIjhOnQoV5D8yMtsshAFZFfJOZ6
 UdQann8k59bEKgVS+4c/qjJy762Avad6dzDpPzVDiz/zgpMf11ixISTpSeE/m/MixoO6
 Cw2YCS9tFHUj18zSE2uEaDovRBmTjdNoi3FzjQORyOX3Q0Y92RFdS0TOYBfY05d2JPeM
 oQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788284050; x=1788888850;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3zPNMVE0OJOjrANZMwm8oXffR5wrlrrxJ1gjkFPtpLc=;
 b=oFchbHzOsn866BNt2bWJFYNw9rCiWvNK+cAspxyhI0ecmsESxxu4GZmRrt3GvKJPDf
 HRpl3UKzft7h8V+8kjFztCbJg1ILsi6L8ve6u0P/sUZLmSOM76YMGUdPqSNORYYE76OE
 Diz/1c/XNqA6PdM/SSRn7tPiYk4wXJTHPGevvt59g5qJxPTfXXDcESQrmDK2AplIkdpS
 XjClcP3OZcv2sWDJCW8wZ4+7WGgufjgO/E5nw/5edmQFWp1B+k777VRIsyEQA0mBwmlT
 X21k1okYMyTWklenilbxby38xwz3uK+2p4GmLJ1TqREKtMU6Vd9o43rDCfvAX0RxQyTp
 z1rw==
X-Gm-Message-State: AFuF++mmmwZE7lNbgKKYUD/2tcN/GXVTZS6yUbvmhdp8+NodWa7GuVql
 0pT4dXe4fiYqGMbQ2nnlCTcWSz9BsPsDpzpui/IGIaBOkuOMqk/24HX0/5G3HvbAPF9q3XmPNVA
 EyoRhqceSSH2gjiJdcxMBlR+oF/A2hhS21ngs8He4LEL5sgAq/Q391wPOUdn+PZ6nFA==
X-Gm-Gg: AYBFou2LwyRrxwgEPT5EBtWlV1KD3l4RrQgOEMcoyL0Mw2Xj9WM4wGY8xuQrw6U4txn
 sDxrllLoLGuOr/OYG7k7iTjXbJdsNKCugvoLTljFG89Ir9w1Nsmt3sJvsuXLy2Si6vmINXaufj2
 l6CH3p76Gtjd3UHxmIacEZF8Of7+yyINTP69lTXk0URxeuwXHLDxxuDLN3TXm14BsVo26BakII8
 sNhQoJn6cFgGshwDjl5MF/25TTFKV8cIpLeBmy6yrmW9MlkpSHc8OQu6kPGqPrZkSeJzPMs/Bxa
 JurQ5j6k1dzQ/wg+2LqbdYXtvaucn6x5d/xHjw72D6dUPAoCigRAQpnYNdOlKlPQjOkX1PQt3dM
 7YAxc6/owQ4jv5iW6APmFrAzVkuua90bON3jMNdeCKtPcm+GQ
X-Received: by 2002:a17:90b:1b0e:b0:38e:2517:5d1f with SMTP id
 98e67ed59e1d1-396d0f8e755mr50730679a91.9.1788284050084; 
 Tue, 01 Sep 2026 10:34:10 -0700 (PDT)
X-Received: by 2002:a17:90b:1b0e:b0:38e:2517:5d1f with SMTP id
 98e67ed59e1d1-396d0f8e755mr50730598a91.9.1788284049676; 
 Tue, 01 Sep 2026 10:34:09 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f95a160sm39702934eec.18.2026.09.01.10.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:34:08 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PATCH v2 10/11] target/hexagon: fix iassign{r,
 w} to cover all threads
Date: Tue,  1 Sep 2026 10:33:52 -0700
Message-Id: <20260901173353.200474-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
References: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfX9p9YGZw2ygYZ
 MIJ0ASj03faeLDTXHw6esG1vjo+NYyJFqyOAPFx1A/6zCAC+i9klzky9m01m6aw1VtB94kGJBzz
 1SeS6fi9bK3r0IBgmVZ2hVVvsRj/FOXUs4MsavMgXFvIP5Q3C+wJrJq5+xw5pZxNNKs7JjcK7Jy
 F0kPaYeJpvBI7wntc8OOYcMA63cVpNJG1W9FiE9JjZeI1s7KUfl0ffT4C0djn+JkHCYIRNGChpH
 cukcDYC8ZWoW22QgQ96Aco5RYyr9K2iVFWDQHnul/br82tOwibZeGfu2p+uROKXyLBbsXT8yKfT
 x88HOIyui0aIYnExC0fqpeTVxlyJE4zD2ULi65VbU0HJTlVYlvhshyZLvgpCtikVGGeTIdoUauH
 3PX4n3m7XbGF1rBdORQE4YXTzs+V/HaufwkK2s/DMj1fIWlSETXtMu2kBD47uE+Uf8mpzgycgA2
 S3iKMw7mxctyxdly/Wg==
X-Authority-Analysis: v=2.4 cv=L6ItheT8 c=1 sm=1 tr=0 ts=6a970c95 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=1MU65uQV28RDXwrdXuMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1NSBTYWx0ZWRfX4l5mrlt3j09v
 MulVcIPSjcPDhwd6afOOzD0FYq9KdDPDPmdVvZuoIDcw40zFs4NylGvQ4GAGzlj173ex6MeSgZf
 DRCIyEjxW5Z1Pc2rgsOrWVtEN0JGU94=
X-Proofpoint-ORIG-GUID: GSBQXd_2uqerkvn7OCkIOuho4Jgk5nHu
X-Proofpoint-GUID: GSBQXd_2uqerkvn7OCkIOuho4Jgk5nHu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010155
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
Reply-to:  Brian Cain <brian.cain@oss.qualcomm.com>
From:  Brian Cain via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

aWFzc2lnbncvaWFzc2lnbnIgd2VyZSBmaWx0ZXJpbmcgQ1BVX0ZPUkVBQ0ggYnkgTU9ERUNUTF9F
LCB0aGUKdGhyZWFkLWVuYWJsZWQgbWFzay4gVGhhdCBtYXNrIHJlZmxlY3RzIHdoZXRoZXIgYSB0
aHJlYWQgaGFzIGJlZW4Kc3RhcnRlZCwgbm90IHdoZXRoZXIgaXQgZXhpc3RzLCBzbyBJTUFTSyB3
cml0ZXMvcmVhZHMgbmV2ZXIgcmVhY2hlZAp0aHJlYWRzIHRoYXQgaGFkbid0IGJlZW4gc3RhcnRl
ZCB5ZXQsIGxlYXZpbmcgdGhlaXIgSU1BU0sgc3RhbGUgb3IKdW5yZWFkYWJsZS4gRHJvcCB0aGUg
TU9ERUNUTF9FIGZpbHRlcmluZyBhbmQgb3BlcmF0ZSBvbiBldmVyeSB0aHJlYWQuCgpSZXZpZXdl
ZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29t
PgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+
Ci0tLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCA0MiArKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDMy
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIv
dGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggZGYzMWVkMjQ4OGEuLmUxOWMzYzkxMDg1
IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTYzNyw2MSArMTYzNywzOSBAQCB2b2lkIEhFTFBFUihjc3dp
KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKIAogdm9pZCBIRUxQRVIoaWFz
c2lnbncpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBzcmMpCiB7Ci0gICAgdWludDMy
X3QgbW9kZWN0bDsKLSAgICB1aW50MzJfdCB0aHJlYWRfZW5hYmxlZF9tYXNrOwogICAgIENQVVN0
YXRlICpjcHU7Ci0gICAgSGV4YWdvbkNQVSAqaGV4X2NwdTsKIAogICAgIEJRTF9MT0NLX0dVQVJE
KCk7Ci0gICAgaGV4X2NwdSA9IGVudl9hcmNoY3B1KGVudik7Ci0gICAgbW9kZWN0bCA9IGhleF9j
cHUtPmdsb2JhbHJlZ3MgPwotICAgICAgICBoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGhleF9jcHUt
Pmdsb2JhbHJlZ3MsIEhFWF9TUkVHX01PREVDVEwsCi0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZW52LT50aHJlYWRJZCkgOiAwOwotICAgIHRocmVhZF9lbmFibGVkX21hc2sgPSBHRVRf
RklFTEQoTU9ERUNUTF9FLCBtb2RlY3RsKTsKIAogICAgIENQVV9GT1JFQUNIKGNwdSkgewogICAg
ICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYgPSAmKEhFWEFHT05fQ1BVKGNwdSktPmVu
dik7Ci0gICAgICAgIHVpbnQzMl90IHRocmVhZF9pZF9tYXNrID0gMHgxIDw8IHRocmVhZF9lbnYt
PnRocmVhZElkOwotICAgICAgICBpZiAodGhyZWFkX2VuYWJsZWRfbWFzayAmIHRocmVhZF9pZF9t
YXNrKSB7Ci0gICAgICAgICAgICB1aW50MzJfdCBpbWFzayA9IHRocmVhZF9lbnYtPnRfc3JlZ1tI
RVhfU1JFR19JTUFTS107Ci0gICAgICAgICAgICB1aW50MzJfdCBpbnRiaXRwb3MgPSAoc3JjID4+
IDE2KSAmIDB4RjsKLSAgICAgICAgICAgIHVpbnQzMl90IHZhbCA9IChzcmMgPj4gdGhyZWFkX2Vu
di0+dGhyZWFkSWQpICYgMHgxOwotICAgICAgICAgICAgaW1hc2sgPSBkZXBvc2l0MzIoaW1hc2ss
IGludGJpdHBvcywgMSwgdmFsKTsKLSAgICAgICAgICAgIHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhf
U1JFR19JTUFTS10gPSBpbWFzazsKKyAgICAgICAgdWludDMyX3QgaW1hc2sgPSB0aHJlYWRfZW52
LT50X3NyZWdbSEVYX1NSRUdfSU1BU0tdOworICAgICAgICB1aW50MzJfdCBpbnRiaXRwb3MgPSAo
c3JjID4+IDE2KSAmIDB4RjsKKyAgICAgICAgdWludDMyX3QgdmFsID0gKHNyYyA+PiB0aHJlYWRf
ZW52LT50aHJlYWRJZCkgJiAweDE7CisgICAgICAgIGltYXNrID0gZGVwb3NpdDMyKGltYXNrLCBp
bnRiaXRwb3MsIDEsIHZhbCk7CisgICAgICAgIHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19J
TUFTS10gPSBpbWFzazsKIAotICAgICAgICAgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwg
IiVzOiB0aHJlYWQgIiBUQVJHRVRfRk1UX2xkCi0gICAgICAgICAgICAgICAiLCBuZXcgaW1hc2sg
MHglIiBQUkl4MzIgIlxuIiwgX19mdW5jX18sCi0gICAgICAgICAgICAgICB0aHJlYWRfZW52LT50
aHJlYWRJZCwgaW1hc2spOwotICAgICAgICB9CisgICAgICAgIHFlbXVfbG9nX21hc2soQ1BVX0xP
R19JTlQsICIlczogdGhyZWFkICIgVEFSR0VUX0ZNVF9sZAorICAgICAgICAgICAiLCBuZXcgaW1h
c2sgMHglIiBQUkl4MzIgIlxuIiwgX19mdW5jX18sCisgICAgICAgICAgIHRocmVhZF9lbnYtPnRo
cmVhZElkLCBpbWFzayk7CiAgICAgfQogICAgIGhleF9pbnRlcnJ1cHRfdXBkYXRlKGVudik7CiB9
CiAKIHVpbnQzMl90IEhFTFBFUihpYXNzaWducikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQz
Ml90IHNyYykKIHsKLSAgICB1aW50MzJfdCBtb2RlY3RsOwotICAgIHVpbnQzMl90IHRocmVhZF9l
bmFibGVkX21hc2s7CiAgICAgdWludDMyX3QgaW50Yml0cG9zOwogICAgIHVpbnQzMl90IGRlc3Rf
cmVnOwogICAgIENQVVN0YXRlICpjcHU7Ci0gICAgSGV4YWdvbkNQVSAqaGV4X2NwdTsKIAogICAg
IEJRTF9MT0NLX0dVQVJEKCk7Ci0gICAgaGV4X2NwdSA9IGVudl9hcmNoY3B1KGVudik7Ci0gICAg
bW9kZWN0bCA9IGhleF9jcHUtPmdsb2JhbHJlZ3MgPwotICAgICAgICBoZXhhZ29uX2dsb2JhbHJl
Z19yZWFkKGhleF9jcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX01PREVDVEwsCi0gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCkgOiAwOwotICAgIHRocmVhZF9lbmFi
bGVkX21hc2sgPSBHRVRfRklFTEQoTU9ERUNUTF9FLCBtb2RlY3RsKTsKICAgICAvKiBzcmMgZmll
bGRzIGFyZSBpbiBzYW1lIHBvc2l0aW9uIGFzIG1vZGVjdGwsIGJ1dCBtZWFuIGRpZmZlcmVudCB0
aGluZ3MgKi8KICAgICBpbnRiaXRwb3MgPSBHRVRfRklFTEQoTU9ERUNUTF9XLCBzcmMpOwogICAg
IGRlc3RfcmVnID0gMDsKICAgICBDUFVfRk9SRUFDSChjcHUpIHsKICAgICAgICAgQ1BVSGV4YWdv
blN0YXRlICp0aHJlYWRfZW52ID0gJihIRVhBR09OX0NQVShjcHUpLT5lbnYpOwotICAgICAgICB1
aW50MzJfdCB0aHJlYWRfaWRfbWFzayA9IDB4MSA8PCB0aHJlYWRfZW52LT50aHJlYWRJZDsKLSAg
ICAgICAgaWYgKHRocmVhZF9lbmFibGVkX21hc2sgJiB0aHJlYWRfaWRfbWFzaykgewotICAgICAg
ICAgICAgdWludDMyX3QgaW1hc2sgPSB0aHJlYWRfZW52LT50X3NyZWdbSEVYX1NSRUdfSU1BU0td
OwotICAgICAgICAgICAgZGVzdF9yZWcgfD0gKChpbWFzayA+PiBpbnRiaXRwb3MpICYgMHgxKSA8
PCB0aHJlYWRfZW52LT50aHJlYWRJZDsKLSAgICAgICAgfQorICAgICAgICB1aW50MzJfdCBpbWFz
ayA9IHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFTS107CisgICAgICAgIGRlc3RfcmVn
IHw9ICgoaW1hc2sgPj4gaW50Yml0cG9zKSAmIDB4MSkgPDwgdGhyZWFkX2Vudi0+dGhyZWFkSWQ7
CiAgICAgfQogCiAgICAgcmV0dXJuIGRlc3RfcmVnOwotLSAKMi4zNC4xCgo=

