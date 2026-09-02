Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C461C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1cow-0000gM-R7; Wed, 02 Sep 2026 00:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1cou-0000du-QV
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1cor-0000Ny-Mp
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:32 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68202Fv71013362
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Et4ny1F1lzuIyJmBjDBu93nVnzwZJsOWaIOzX7PHa9c=; b=VzChwmP2YXwpPHgX
 uqyKxRk3mCr1sD+t2clo7Zy4gnM+ljEUAhMdUbHKh2giIhs4Z0Tzbs9fSTwJKWxv
 DmmgcC7WE42Y3DIQ7Tj0OCfqjAscKV+TA/b349UW4hBw81f7rBsbIdsfltHILeVB
 uCIG59B3WKX9IG7fd5LokKBZXaxVXnqwxw+NOd5AuoK4FwcTySoXhsTJ9DczUaUn
 SYqm1aOlTIhQA4I5l+oYfN56wleTo41uglg39TYM8Gq3sd5C+Mdik4W/Rx6QoByD
 MiJtO7q2RWIisD9Y2msUbr4ePi6wgTEWeqeDezoOxrhG9/HfvzFhk9tJaVP7A4BO
 OlBqVA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge8whgsm8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:43:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-398fe469aa0so1060473a91.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324197; x=1788928997; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Et4ny1F1lzuIyJmBjDBu93nVnzwZJsOWaIOzX7PHa9c=;
 b=DVfIJPcProQ4uoeJFEekdfSXPjY0pprDf5tbg0rPicSuUjMy12PJuiMWf9GarwJZ2Y
 dPDP9Seb/vwpGH1VI15xUWhCNKOfBPqrEp3q2qZk8yyK7/InFETyu6N/AaeztBl+IKuj
 pdGhgd7FK7F0x+381FZ3zN5QCnTs2CNALebqfqGEsLhQbHsAbG8jCwiBVzzeCl6gEFxd
 KO/lpdCoFvZ5P2cqyb+liyAeM5dx1T2lu1XdjNm1qc6BkzOYs1Sw0ul3dHjYRxEVBwXY
 a+k0oGlk0YojpvgDyPtHiZokEShIv+MfZ2F2oMleNSLu93aeJfdore5fTsoko5vAVPaV
 qcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324197; x=1788928997;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Et4ny1F1lzuIyJmBjDBu93nVnzwZJsOWaIOzX7PHa9c=;
 b=j5lnLjMse4mgvpJvgUMA8KfSebD+e6Vz7iBufH2ps/5gAzG4odsDI/zpiBro1AbqPR
 D71uuBQqzd+E6mnxoxaT4xmIDos2OnsfdgndcoZyJvRnc4EuoPMIzTWpwZH5Hy2grSh6
 93IXsXp6PCQedxMa7je1TC/R+W4IcCioOwu+BgRMZ8QAmT/PTJPRoZS7p6qVc8Ka12xZ
 QUdQ1y5Q8rmG1zBBKcQZZ5urmrraD186luInG8okHzMzaV6bHImzD3eKsp/xmMBSb3kl
 mhe1rKERZBEKi040vVXpsiOK4Gj4aM/thQ5NlRpLc2al+niAh6I/XhhuG6zQ1dzcl9gl
 4gZg==
X-Gm-Message-State: AFuF++mAuq50XekEkocdc15BoQLxoOCnni5BAEV2rLuU++3r1zYmM+Xi
 2ujsn2OwGfUNVnz+5sFnUTCghEqtykC53wXNLww2iH0vOg1Hcn5nQqp46eZY/9x29z3cEGcnkLR
 AL/CRClzw/y41047YTBPZhE6eEpd30WSAumHe7t1xbjnWuWydM4awq3eMFH7yLzES3A==
X-Gm-Gg: AYBFou0FHvBiYYfpqLq1qc+qYTYMA9MkPq0HbkrTga+ThaZPMN7wMRzqkz/vti1twqD
 KIH7zKWcl53Q5TjvWPL/w8XCiVgzw5MkjrtmiYC5zovKDqDDUFPJFQSJWj4BLKzfY3XBzjJY+w1
 0qHbWezGSuNQwQTmWU329/9TdXmDLKfqW8mlJVb5xRMEgZk2KlpDYzAZw9xuObSWmDOxqD6m7P+
 /+vTY7UQmeKBDAOdmjHKy4UynAJ5sr5wTE7aT2VL9Dhy/eZgxQ+aJd7THEpCysJb1fOO+4WbdKJ
 /sa9JgQi1bkKjfqnq0NWm3E68xioJAKhGzfiydizMDGhjGTQFPSaiflGr7vnaYXZwYW9KeYG5tE
 E2FWwEorYQxK5N8VapnsOicvZkE0YcKy2BD58+Hp1e4S02Bg9
X-Received: by 2002:a17:90b:1e04:b0:38f:57f0:1f5d with SMTP id
 98e67ed59e1d1-39aee16ffd9mr2318008a91.15.1788324196931; 
 Tue, 01 Sep 2026 21:43:16 -0700 (PDT)
X-Received: by 2002:a17:90b:1e04:b0:38f:57f0:1f5d with SMTP id
 98e67ed59e1d1-39aee16ffd9mr2317972a91.15.1788324196468; 
 Tue, 01 Sep 2026 21:43:16 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:43:15 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 23/28] target/hexagon: fix iassign{r, w} to cover all threads
Date: Tue,  1 Sep 2026 21:42:26 -0700
Message-Id: <20260902044231.843004-24-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=fLkJG5ae c=1 sm=1 tr=0 ts=6a97a965 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=1MU65uQV28RDXwrdXuMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: Yjps2WyK9adaAK7XgRJRQXJSXizJkoX-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfXxvwj2/ethK+n
 Afcrzs7Qx8VnyidRmmBUz6lCYefrHZxBaUmrUZUd/WEpMU0ywU5OlsjIjfUT6LqPEfVlOX3pjgS
 bv4m4KVqbZS2Oi0ebBpyoI+Qtom1vDmzHnVME1sLJu4565TddSKg8peKNMd79chldRGicA8V46Y
 kTAU1YuygvyYdJOgkORy90V0r+xncIu1iwsJsHmEb0Geq+rgLntPxZEbaD+RFdQnEZAU1tVysFG
 Wg6XFP6TpDsjlq9pAnFFgI/Ut1Z/teL8UxlB7Bi/8Vpyjknlj9lmUJ2IeiHjcF1eF9LpRLBV6Aj
 wdFieKQqIfyLZjNddYtFZ4KAHseeApS4ECicHLnWLuKCOcmcAZfZmnXyeFnH4+RE1ZFuiz6weZl
 XCuyDdYdBt8jajI5bZReUjF43qN/l1nUX8/TKR9g5xqT7im6cwAHLYcQyjmrGvItRe08gpH6ASs
 xfZ1TJ5CvOxZQ03nWeg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX3CJchKdd1TtQ
 znaSYlI/KRoPtmEeWMX3wXqlklTY7diBXuC53LWorL5oi4TEM4HdXQlOWl3PGApFIVYz/esXT/o
 t7L8TX/GL2XVUxhDPbz0Dpx0IphSo5U=
X-Proofpoint-GUID: Yjps2WyK9adaAK7XgRJRQXJSXizJkoX-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
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
dGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggZjllNjZhY2Y4NDguLjIxNjhjNjM2MWQ5
IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4
YWdvbi9vcF9oZWxwZXIuYwpAQCAtMTYzNSw2MSArMTYzNSwzOSBAQCB2b2lkIEhFTFBFUihjc3dp
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

