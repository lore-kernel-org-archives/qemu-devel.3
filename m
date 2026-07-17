Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F423DC4451B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 19:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wko2U-0006mi-Ey; Fri, 17 Jul 2026 15:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2S-0006mS-GC
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:16:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wko2Q-000849-Vd
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 15:16:00 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HGo99f2245287
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KDJzGtVRreS6z/6TMGz95VQOL0sQrxpRLTHH3sel420=; b=OxCvb/7JGjpYH3u/
 Wl/SopaHdAHqDHWp47RNGcq4/2cS+dRcDNJT9yK0Pe1DbN0XD+joe6qrgFs1EjUI
 nq3OQon7SGTIc6XHvqaV5hw0RG9493xr3dPhc9BJXwZtiFqai+u7ks3ATEjqKPy0
 Paw6wiWxLZkaFrCeSAGc8Te9HWjUWYKmAc5xk6rQuZhRqMXklGtPv/fAd0FGWhqN
 snJYL4FCNOqmNvo9JKjomKVBa1O5fs+jFLEDxoIDCjL1QCSKYoSCtFMNhKOwSeYt
 jjmHpR31omWgY/uWETNnwBU2SeLDorPjyl8/ZDfZZDsDwTW6UAsmCv1YcTUv02xv
 0xT2yA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9pay3q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 19:15:57 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-381250979d5so5494290a91.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 12:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784315757; x=1784920557; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KDJzGtVRreS6z/6TMGz95VQOL0sQrxpRLTHH3sel420=;
 b=gNEkkOIhQhf/Mvpg6if03IOHoYqyQqZiHSAI8iUP2PEUfOqMABKlbKPDyBV/+Dmb0A
 wPYFVVTZXg4J/yNmBwyuf+pPLp1WPuL9zQSDjaK+g0GvRpNqUpcOndgOg91Ajl8MVvFJ
 xDOjrzRERjD7mRjwuM9ZvgeU7DDwCHyprrwcAqIvA32dtJM2SalK0D9B+2EuP1/QwxSK
 f4xicCzqLvvxs34vQzOvaAVZwTGnO6cVXRlbJFbRZbs3z9HTq3xEcd/J1yKrF8UfWfqr
 VJLuSI5FISS1/RS+ZYTtoQ2hDXB7bXKQN/6UJqAN2Gadj1f4P1R/xY0iRZ2fl+HmQIYC
 v/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784315757; x=1784920557;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KDJzGtVRreS6z/6TMGz95VQOL0sQrxpRLTHH3sel420=;
 b=UktleH4yRCc/wkWadARye0pI6McyFt629ZsdV96Y8qTC5VyAvYhx7XsSF2ocVzmtW9
 Sgu3X/d50ggiu49Vj9o9QZf8lBIdYOXiRJ0G88ekN7qCFzO7l9qi+zKZiVK80AxhcGHR
 S/5249BzYPaEjALMAmqNLGKzHOEaCtrXYb+CBEFbaSQBnMxA0c+zt+D9f3OpmmEb+wMV
 DhFWAuTdNG7xgyFwNTec94+9pCU6WJsCgK7sqMF2ABBxSjC/3pYexF+YbExqO9ducJ2D
 P+r32PNmWYXB9Ba0fdPE3EkIK10ro9dBMyyfLwFxnlCwzXz3qKi3r1lP/idlL+qk5g1E
 8Jjw==
X-Gm-Message-State: AOJu0YzXHDdBb5cVZe0ewzsQIzjVY+V6A3hEWPWWVNvkD2Gu9PnQzLj4
 9SAU3Omc6yPZitWw5LKsi+7Wlygh5Rwda+oniZtUTLZ3/Ga8VL6QSZquVaVaklW1mlQ0enz72YE
 Uj49Yhfd2/UNznO5BvcBJjUeAWmFmoMxAjrdG8iCPeRe0SJkNoPmJzeINfrH3fksiOw==
X-Gm-Gg: AfdE7ckhxtVsE/nK6zRfscmaKKHmO4/QS+MzmjF+liGiSVee/iu5/udARzDgcmziiGl
 tA0W4B44idzjm4Qbku9b5WN5kNK/sMhMLiHh9gTJ8L5trfj0baRKG4YMB2ki8ZZfFkIsUG3msgg
 AHfyZ+27YrUamDFaTeguohEbMu3voKo+OVk4xxUcxlLJZpHCqyTdQatRoLrholgEBywJ39biD3z
 XjJh6M00ZcntTYjVjp60c2kriCfA/H15Mw1XZm18+kcry+tnv5xB5Cim1rgYbpSSxOf1nrccwdf
 7AVaYikLpraF/TMzvDFRwCG26o/I/fIsQPoZnUQmdz7bME5lKj9oYmjJCke2Jp9yB3ptGExlva9
 ufCtmq/AclXBC2KVB/8BoX9OiM48OWOjb8VTkk6NcmYjDi5vs
X-Received: by 2002:a17:90b:2f0f:b0:387:e0db:bc31 with SMTP id
 98e67ed59e1d1-38e4b56ed5fmr3914797a91.39.1784315756972; 
 Fri, 17 Jul 2026 12:15:56 -0700 (PDT)
X-Received: by 2002:a17:90b:2f0f:b0:387:e0db:bc31 with SMTP id
 98e67ed59e1d1-38e4b56ed5fmr3914734a91.39.1784315756211; 
 Fri, 17 Jul 2026 12:15:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d444sm11602463eec.6.2026.07.17.12.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 12:15:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, stefanha@redhat.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 03/12] target/hexagon: fix -Wshadow=local build error on GCC 14
Date: Fri, 17 Jul 2026 12:15:38 -0700
Message-Id: <20260717191547.920048-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
References: <20260717191547.920048-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: K9x_mouJK22wW7HrlHdqZ-MIjNVUW-4u
X-Proofpoint-ORIG-GUID: K9x_mouJK22wW7HrlHdqZ-MIjNVUW-4u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX2/vbuRcGSoQO
 LE2r6zdPaxA0bnlExbursM/JMjIfDnBWJeuJOB3k/ZKMR6cPyd8AKumrxo9klgTIWHIpo4HieXI
 CmOoH9MX7YZvq6+lXfCBOcwp7yLeoPuWF7U5ABmfATrpL3JrV/mk3JvU7kEtj0Nd4tA9wBCPqjn
 i3ZKdn5K1AUNYoTpu9SRtfgsK52HZOnz5u0MdE7dSGmNcNDW6Sh6adlet9lKO+Yg8QXQSPETbc2
 bFk274YGEiC6NB5jEBnnNTvNgkpiQSWZo2vdNCzrwzS1tacAfxpFlxXN1TRQMe15G6oQmwnZou+
 rLJaHnU2aCJfDOwclfAxN/Wnu48wez+gssltOqhFh9HFHtB/1HqdiP2sW8zcyi0Dop61CYJd8jk
 waEbbcAIqbDbtUisTi08nNhHlcEGsUdtOBFrQmXaAG/MJnqFr1l1SB6YOjG5potgZ+khV/O3PTz
 EwamfElh5p1Wri8EXHw==
X-Authority-Analysis: v=2.4 cv=TaqmcxQh c=1 sm=1 tr=0 ts=6a5a7f6d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=BJvf2dmcNa1hIKecAfkA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE5NyBTYWx0ZWRfX8xWWD8xAlzcm
 mef+LSanyd/8m8vaTOydBVfJtNwi3gMiMtL3bjxqCts5VGromJwCELNf0CHUHzPJ09xkiW5t3KZ
 twmQf49ygDcdoVYZLgmXJTMISEx1t5E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170197
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

V2l0aCAtLWRpc2FibGUtaGV4YWdvbi1pZGVmLXBhcnNlciwgdGNnX2Z1bmNzX2dlbmVyYXRlZC5j
LmluYyBmYWlscwp0byBidWlsZCB1bmRlciBHQ0MgMTQgd2l0aDoKCiAgZXJyb3I6IGRlY2xhcmF0
aW9uIG9mICdIQUxGJyBzaGFkb3dzIGEgcHJldmlvdXMgbG9jYWwKICBbLVdlcnJvcj1zaGFkb3c9
bG9jYWxdCgpUaGlzIGJlY2FtZSBhIGhhcmQgZXJyb3Igd2l0aCBHQ0MgY2VkNjUxYjc3NTdlIGBj
MjM6IHRhZyBjb21wYXRpYmlsaXR5CnJ1bGVzIGZvciBlbnVtc2AuCgpBZnRlciB0aGF0IEdDQyBj
aGFuZ2UsIERFQ0xfRklMRV9TQ09QRV9QIGlzIGZhbHNlIGZvciBhbGwKZW51bWVyYXRvcnMsIHNv
IHNoYWRvd2luZyBub3cgZmFsbHMgdW5kZXIgLVdzaGFkb3c9bG9jYWwuCgpSZW5hbWUgdGhlIGxv
Y2FsIHZhcmlhYmxlIHRvIHRtcF9oYWxmIHRvIGF2b2lkIHRoZSBjb2xsaXNpb24uCgpSZXZpZXdl
ZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNvbW0uY29t
PgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+
Ci0tLQogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oIHwgNCArKy0tCiB0YXJnZXQvaGV4YWdvbi9t
YWNyb3MuaCAgfCA0ICsrLS0KIDIgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCBiL3Rhcmdl
dC9oZXhhZ29uL2dlbl90Y2cuaAppbmRleCBhMjhhZjBjMjQ1Yi4uNDBlMDM3ODFkMzYgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5f
dGNnLmgKQEAgLTQxNCw3ICs0MTQsNyBAQAogCiAjZGVmaW5lIGZHRU5fVENHX1NUT1JFKFNIT1JU
Q09ERSkgXAogICAgIGRvIHsgXAotICAgICAgICBUQ0d2IEhBTEYgR19HTlVDX1VOVVNFRCA9IHRj
Z190ZW1wX25ldygpOyBcCisgICAgICAgIFRDR3YgdG1wX2hhbGYgR19HTlVDX1VOVVNFRCA9IHRj
Z190ZW1wX25ldygpOyBcCiAgICAgICAgIFRDR3YgQllURSBHX0dOVUNfVU5VU0VEID0gdGNnX3Rl
bXBfbmV3KCk7IFwKICAgICAgICAgU0hPUlRDT0RFOyBcCiAgICAgfSB3aGlsZSAoMCkKQEAgLTQy
Miw3ICs0MjIsNyBAQAogI2RlZmluZSBmR0VOX1RDR19TVE9SRV9wY3IoU0hJRlQsIFNUT1JFKSBc
CiAgICAgZG8geyBcCiAgICAgICAgIFRDR3YgaXJlZyA9IHRjZ190ZW1wX25ldygpOyBcCi0gICAg
ICAgIFRDR3YgSEFMRiBHX0dOVUNfVU5VU0VEID0gdGNnX3RlbXBfbmV3KCk7IFwKKyAgICAgICAg
VENHdiB0bXBfaGFsZiBHX0dOVUNfVU5VU0VEID0gdGNnX3RlbXBfbmV3KCk7IFwKICAgICAgICAg
VENHdiBCWVRFIEdfR05VQ19VTlVTRUQgPSB0Y2dfdGVtcF9uZXcoKTsgXAogICAgICAgICB0Y2df
Z2VuX21vdl90bChFQSwgUnhWKTsgXAogICAgICAgICBnZW5fcmVhZF9pcmVnKGlyZWcsIE11Viwg
U0hJRlQpOyBcCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCBiL3RhcmdldC9o
ZXhhZ29uL21hY3Jvcy5oCmluZGV4IDIxYWI4YWU1YmJmLi44YTMyZDVmNzljMiAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgK
QEAgLTU3Niw4ICs1NzYsOCBAQCBzdGF0aWMgaW5saW5lIFRDR3YgZ2VuX3JlYWRfaXJlZyhUQ0d2
IHJlc3VsdCwgVENHdiB2YWwsIGludCBzaGlmdCkKICAgICB9IHdoaWxlICgwKQogCiAjaWZkZWYg
UUVNVV9HRU5FUkFURQotI2RlZmluZSBmR0VUSEFMRihOLCBTUkMpICBnZW5fZ2V0X2hhbGYoSEFM
RiwgTiwgU1JDLCB0cnVlKQotI2RlZmluZSBmR0VUVUhBTEYoTiwgU1JDKSBnZW5fZ2V0X2hhbGYo
SEFMRiwgTiwgU1JDLCBmYWxzZSkKKyNkZWZpbmUgZkdFVEhBTEYoTiwgU1JDKSAgZ2VuX2dldF9o
YWxmKHRtcF9oYWxmLCBOLCBTUkMsIHRydWUpCisjZGVmaW5lIGZHRVRVSEFMRihOLCBTUkMpIGdl
bl9nZXRfaGFsZih0bXBfaGFsZiwgTiwgU1JDLCBmYWxzZSkKICNlbHNlCiAjZGVmaW5lIGZHRVRI
QUxGKE4sIFNSQykgKChpbnQxNl90KSgoU1JDID4+ICgoTikgKiAxNikpICYgMHhmZmZmKSkKICNk
ZWZpbmUgZkdFVFVIQUxGKE4sIFNSQykgKCh1aW50MTZfdCkoKFNSQyA+PiAoKE4pICogMTYpKSAm
IDB4ZmZmZikpCi0tIAoyLjM0LjEKCg==

