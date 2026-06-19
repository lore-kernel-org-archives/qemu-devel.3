Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9461CDB46D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waig6-0004FZ-Dm; Fri, 19 Jun 2026 19:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waig1-0004BE-Nv
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:31:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waify-0007W3-Lf
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:31:08 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLYIxJ1336793
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=H59yHYX/QB4nYfdzTuOV85Wghdkfd+Q1FyRwAv3AWf4=; b=dD
 FGq2r7xRS6tYeWztTF7tJhjSFs6d1jKETIBxyR2ZqN7lNaR7YYQn2niYs1dWXEEN
 CTwLyodLyPHD8K2MTcf0/x0cbhbCKv32waGoFGqOgFnbDkoZz7hVCKLDfIknOc7p
 8EIN6PQOc29RKLaegZssUA90Xg07W9iXt483DnorYdi76C1l0fYqSfN0WMgXcAnw
 xr7hdqhaCGhe308ZrmErtSOVfuSdVA6+woYs3dN2Zhzpxmx+Q7y1vRH9RLts4BTn
 cqDyhJ8FZcGV7wltSMVW0snUtCikjHp+T0D8BEWMjG794tGB0GQbG2pUdQ9Hor4J
 4wXcwzd1/LV/plMomhJA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp6757b1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:54 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30bcbb34e57so4177512eec.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911854; x=1782516654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H59yHYX/QB4nYfdzTuOV85Wghdkfd+Q1FyRwAv3AWf4=;
 b=PlvgrKJnFc79smc05nzVxqj3GHS91hd2IITpAJQvsQv+6lJAtz2JuPpdtGjTxapMx+
 93xxPnCRLv1unO7C4Ey4693Qwid9AehSczmrKvkwLGYm3BvKCncejOiaJHwiqLtDVXAF
 yZxZSGhCSYZcYxAx6GwCeTPyCe4N78gbeJmGppYDNvbqDV62Bxfb7WzJsOT1dwB//85q
 WMJWcWJF4nVnrqmDXZrxrUP1AwwyC2ZfJciuvpalJX+B+hyksu9Fgfk0ZgykekXMZI1b
 qBkNbP6BU9pbGSWplYMHVksiQs4KQyajVRRKeuPjIgZcS14hrg2arBpd8G1pmW7cPBpS
 ooDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911854; x=1782516654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H59yHYX/QB4nYfdzTuOV85Wghdkfd+Q1FyRwAv3AWf4=;
 b=P2lRDoFV8D3qhzAdBxk2ueVT4EiWzVkkrMH1ZO1e4le1b3pARWTurPNFLcsJ6oQ9Gu
 YZBZon/6lC39QfbezH3C6MND28RvR+/ITju6MXDi+D/kb7aL6DNo10OpzfqFaf6Aj4gS
 6Nd6G0uOHFa4tvS3hoVup6QWQ4J2/yqQ2v/4yIRCtYx15qHvKNCa5VuIG/VEFXFQqUlf
 YYuVHmb/x8pSoQk7lpDQvaGYxQK/ZYSQoSRkBLcLSfHrmi5aoOv22coMtEdY1het4wtE
 uvtu/vtF+mPNTSW74Bc8c3cAPPvkRqE3RtFMkY9f+jtTQV95SzobG8EkhYlnh7hKR62j
 duHw==
X-Gm-Message-State: AOJu0YwUfZ1mcPW5nfdmgGOtbPNwEDH7Pc1jYW8NwwI0maIiYBe0Q5Lh
 tMJlIzP9b/RZbe574jFIvUX0lQGWECNJu0f50VA1Dtgfpmo0uT/WUVTPPU4NQKsg7J5kqPFKe88
 MnDNU6onHnezks8UsQIk/+ScCcsfo68IYf4pJoi9/LBMqxE2KFW3Z/KhoDExR1ncIug==
X-Gm-Gg: AfdE7cmfImhvH3uouPABi06cAQM8z0XbzDTXzQ7dUCpHbRNw8h7ppRH/M8zR9Up7Ot7
 xm31KGPahrR8/AJRmwZcoboArbdXhRuT9lRqEvtVyxfS0Qx8AyK/ybvushqgVBF0hW0rpLQdjUb
 i0PR2+AxYu/tqRTSZm73LMfVamc2hl5EOfv5TF6VOkVyRmUSTQ7xNKIkY2+hcD62BqBrFznhe3U
 wZu7hY7N33SVYazKCbedXb5/OLAF64g1+EMUDME19LFK563/5UbT5Ngl0hMF4H8CGp1hPvDfinm
 BUqz853gPbTP2d3GlHHfxOoCWOC9HsaizmzjtWNkUVIm0Qj7XPYC6B13GI/Yt8wfE3OvCtl0HQc
 n2W+lehXMAD2Jkto493sAa+k7EEWbkIu97sfdrBoO9tiN3DdMZshkV3ZYD3A=
X-Received: by 2002:a05:7300:f10a:b0:304:d8e2:3c4d with SMTP id
 5a478bee46e88-30c071d1c0emr2683158eec.25.1781911853998; 
 Fri, 19 Jun 2026 16:30:53 -0700 (PDT)
X-Received: by 2002:a05:7300:f10a:b0:304:d8e2:3c4d with SMTP id
 5a478bee46e88-30c071d1c0emr2683146eec.25.1781911853457; 
 Fri, 19 Jun 2026 16:30:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 69/74] hw/hexagon: Add v68, sa8775-cdsp0 defs
Date: Fri, 19 Jun 2026 15:59:06 -0700
Message-Id: <20260619225911.159473-70-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: sfPISECLk5llh5G4UDEAkXGmY9harVmS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX2VZpro+RWgxF
 UCSUmFteTefZlosJdfpXL6rkZM8OyJXhZ9vGsghqYJSMRG1WocyEjBThgE/dzuS511g5iq1mjtg
 8NRU+h4y19K7Sh2yR9PCgzP+RcFXH63eGGln8GKShne2EqjvYeo2clkJXbk1znxdXf8dn4RNZqe
 3nlxEXWJzgMgx32Gmh6RJGledaFn0I0W6VDFhh4WRpHqryrLnhmMD8Gz5W/FR7Kq97jr7R3AU9R
 Xw4rMetWYOHzTX64YFCuK1XZq7L+qkAJUkp5gXuQjD3v5R3OmqAPD0iodSNAVsAz0x83swIZCf+
 o6YozKDYCVVxffFRYbOee8LSPFTrK7/LDzZy/z6GEW7/Nxxa82icg9PPscsn6BWuAUlosLzE4DO
 04PCufPUbcd0MoGRc9DLCyIGIkYOb3+YjTaz/R1VzxKkttRLgAY5gbHi8GFZt5hD3NrkMyoII6m
 XAKkqXzytm1UAwLqQnQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX9Epd7/TK4fcs
 b7cYJ4roAAt6POLYOOetuxpeI6cg2RXwMskT93dEvgh7U9sBnGB2mI8zwqKKGyEFbgSCgnAPkC7
 xOw90s4nDGkGPjdL0UfMA7i/uc0FTto=
X-Proofpoint-GUID: sfPISECLk5llh5G4UDEAkXGmY9harVmS
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a35d12e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=G5se95cPlkO2hgD9IGUA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190226
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBY2tlZC1ieTogVGF5bG9yIFNp
bXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KQWNrZWQtYnk6IFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJp
YW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGh3L2hleGFnb24vbWFj
aGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jIHwgNjQgKysrKysrKysrKysrKysrKysrKysrKwog
aHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMgICAgfCA2NSArKysrKysrKysr
KysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMjkgaW5zZXJ0aW9ucygrKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMK
CmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYyBi
L2h3L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jCm5ldyBmaWxlIG1vZGUg
MTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi40NDJjYmUzYmUzMQotLS0gL2Rldi9udWxsCisrKyBi
L2h3L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jCkBAIC0wLDAgKzEsNjQg
QEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICovCisKK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2NvbmZpZyBTQTg3NzVQX2Nkc3AwID0g
eworICAgIC5jZmdiYXNlID0gICAgICAgICAweDI0MDAwMDAwICsgMHgxODAwMDAsCisgICAgLmwy
dGNtX3NpemUgPSAgICAgIDB4MDAwMDAwMDAsCisgICAgLmwydmljX2Jhc2UgPSAgICAgIDB4MjYz
MDAwMDAgKyAweDkwMDAwLAorICAgIC5sMnZpY19zaXplID0gICAgICAweDAwMDAxMDAwLAorICAg
IC5jc3JfYmFzZSA9ICAgICAgICAweDI2MzAwMDAwLAorICAgIC5xdG1yX3JlZ2lvbiA9ICAgICAw
eDI2MzAwMDAwICsgMHhBMTAwMCwKKyAgICAuY2ZndGFibGUgPSB7CisgICAgICAgIC5sMnRjbV9i
YXNlID0gMHgwMDAwMjQwMCwKKyAgICAgICAgLnJlc2VydmVkMCA9IDB4MDAwMDAwMDAsCisgICAg
ICAgIC5zdWJzeXN0ZW1fYmFzZSA9IDB4MDAwMDI2MzgsCisgICAgICAgIC5ldG1fYmFzZSA9IDB4
MDAwMDI0MTksCisgICAgICAgIC5sMmNmZ19iYXNlID0gMHgwMDAwMjQxYSwKKyAgICAgICAgLnJl
c2VydmVkMSA9IDB4MDAwMDI0MWIsCisgICAgICAgIC5sMXMwX2Jhc2UgPSAweDAwMDAyNTAwLAor
ICAgICAgICAuYXhpMl9sb3dhZGRyID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLnN0cmVhbWVyX2Jh
c2UgPSAweDAwMDAwMDAwLAorICAgICAgICAucmVzZXJ2ZWQyID0gMHgwMDAwMDAwMCwKKyAgICAg
ICAgLmZhc3RsMnZpY19iYXNlID0gMHgwMDAwMjQxZSwKKyAgICAgICAgLmp0bGJfc2l6ZV9lbnRy
aWVzID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLmNvcHJvY19wcmVzZW50ID0gMHgwMDAwMDAwMSwK
KyAgICAgICAgLmV4dF9jb250ZXh0cyA9IDB4MDAwMDAwMDQsCisgICAgICAgIC52dGNtX2Jhc2Ug
PSAweDAwMDAyNTAwLAorICAgICAgICAudnRjbV9zaXplX2tiID0gMHgwMDAwMjAwMCwKKyAgICAg
ICAgLmwydGFnX3NpemUgPSAweDAwMDAwNDAwLAorICAgICAgICAubDJlY29tZW1fc2l6ZSA9IDB4
MDAwMDAwMDAsCisgICAgICAgIC50aHJlYWRfZW5hYmxlX21hc2sgPSAweDAwMDAwMDNmLAorICAg
ICAgICAuZWNjcmVnX2Jhc2UgPSAweDAwMDAyNDFmLAorICAgICAgICAubDJsaW5lX3NpemUgPSAw
eDAwMDAwMDgwLAorICAgICAgICAudGlueV9jb3JlID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwy
aXRjbV9zaXplID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwyaXRjbV9iYXNlID0gMHgwMDAwMjQw
MCwKKyAgICAgICAgLnJlc2VydmVkMyA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5kdG1fcHJlc2Vu
dCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5kbWFfdmVyc2lvbiA9IDB4MDAwMDAwMDMsCisgICAg
ICAgIC5odnhfdmVjX2xvZ19sZW5ndGggPSAweDAwMDAwMDA3LAorICAgICAgICAuY29yZV9pZCA9
IDB4MDAwMDAwMDAsCisgICAgICAgIC5jb3JlX2NvdW50ID0gMHgwMDAwMDAwMCwKKyAgICAgICAg
LmNvcHJvYzJfcmVnMCA9IDB4MDAwMDAwNDAsCisgICAgICAgIC5jb3Byb2MyX3JlZzEgPSAweDAw
MDAwMDIwLAorICAgICAgICAudjJ4X21vZGUgPSAweDAwMDAwMDAxLAorICAgICAgICAuY29wcm9j
Ml9yZWcyID0gMHgwMDAwMDAwOCwKKyAgICAgICAgLmNvcHJvYzJfcmVnMyA9IDB4MDAwMDAwMjAs
CisgICAgICAgIC5jb3Byb2MyX3JlZzQgPSAweDAwMDAwMDAwLAorICAgICAgICAuY29wcm9jMl9y
ZWc1ID0gMHgwMDAwMDAwMiwKKyAgICAgICAgLmNvcHJvYzJfcmVnNiA9IDB4MDAwMDAwMTYsCisg
ICAgICAgIC5jb3Byb2MyX3JlZzcgPSAweDAwMDAwMDA2LAorICAgICAgICAuYWNkX3ByZXNldCA9
IDB4MDAwMDAwMDEsCisgICAgICAgIC5tbmRfcHJlc2V0ID0gMHgwMDAwMDAwMCwKKyAgICAgICAg
LmwxZF9zaXplX2tiID0gMHgwMDAwMDAxMCwKKyAgICAgICAgLmwxaV9zaXplX2tiID0gMHgwMDAw
MDAyMCwKKyAgICAgICAgLmwxZF93cml0ZV9wb2xpY3kgPSAweDAwMDAwMDAyLAorICAgICAgICAu
dnRjbV9iYW5rX3dpZHRoID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLnJlc2VydmVkNCA9IDB4MDAw
MDAwMDEsCisgICAgICAgIC5yZXNlcnZlZDUgPSAweDAwMDAwMDAwLAorICAgICAgICAucmVzZXJ2
ZWQ2ID0gMHgwMDAwMDAwMywKKyAgICAgICAgLmNvcHJvYzJfY3Z0X21weV9zaXplID0gMHgwMDAw
MDAwYSwKKyAgICAgICAgLmNvbnNpc3RlbmN5X2RvbWFpbiA9IDB4MDAwMDAwZTAsCisgICAgICAg
IC5jYXBhY2l0eV9kb21haW4gPSAweDAwMDAwMDgwLAorICAgICAgICAuYXhpM19sb3dhZGRyID0g
MHgwMDAwMDAwMCwKKyAgICB9LAorfTsKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vbWFjaGluZV9j
ZmdfdjY4bl8xMDI0LmguaW5jIGIvaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5p
bmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAuLjgyNjE5YzQyYWMxCi0t
LSAvZGV2L251bGwKKysrIGIvaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMK
QEAgLTAsMCArMSw2NSBAQAorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3It
bGF0ZXIgKi8KKworc3RhdGljIGNvbnN0IHN0cnVjdCBoZXhhZ29uX21hY2hpbmVfY29uZmlnIHY2
OG5fMTAyNCA9IHsKKyAgICAuY2ZnYmFzZSA9ICAgICAgICAgICAweGRlMDAwMDAwLAorICAgIC5s
MnRjbV9zaXplID0gICAgICAgIDB4MDAwMDAwMDAsCisgICAgLmwydmljX2Jhc2UgPSAgICAgICAg
MHhmYzkxMDAwMCwKKyAgICAubDJ2aWNfc2l6ZSA9ICAgICAgICAweDAwMDAxMDAwLAorICAgIC5j
c3JfYmFzZSA9ICAgICAgICAgIDB4ZmM5MDAwMDAsCisgICAgLnF0bXJfcmVnaW9uID0gICAgICAg
MHhmYzkyMTAwMCwKKyAgICAuY2ZndGFibGUgPSB7CisgICAgICAgIC5sMnRjbV9iYXNlID0gMHgw
MDAwZDgwMCwKKyAgICAgICAgLnJlc2VydmVkMCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5zdWJz
eXN0ZW1fYmFzZSA9IDB4MDAwMGZjOTAsCisgICAgICAgIC5ldG1fYmFzZSA9IDB4MDAwMGQ4MTks
CisgICAgICAgIC5sMmNmZ19iYXNlID0gMHgwMDAwZDgxYSwKKyAgICAgICAgLnJlc2VydmVkMSA9
IDB4MDAwMDAwMDAsCisgICAgICAgIC5sMXMwX2Jhc2UgPSAweDAwMDBkODQwLAorICAgICAgICAu
YXhpMl9sb3dhZGRyID0gMHgwMDAwMzAwMCwKKyAgICAgICAgLnN0cmVhbWVyX2Jhc2UgPSAweDAw
MDBkODFjLAorICAgICAgICAucmVzZXJ2ZWQyID0gMHgwMDAwZDgxZCwKKyAgICAgICAgLmZhc3Rs
MnZpY19iYXNlID0gMHgwMDAwZDgxZSwKKyAgICAgICAgLmp0bGJfc2l6ZV9lbnRyaWVzID0gMHgw
MDAwMDA4MCwKKyAgICAgICAgLmNvcHJvY19wcmVzZW50ID0gMHgwMDAwMDAwMSwKKyAgICAgICAg
LmV4dF9jb250ZXh0cyA9IDB4MDAwMDAwMDQsCisgICAgICAgIC52dGNtX2Jhc2UgPSAweDAwMDBk
ODQwLAorICAgICAgICAudnRjbV9zaXplX2tiID0gMHgwMDAwMTAwMCwKKyAgICAgICAgLmwydGFn
X3NpemUgPSAweDAwMDAwNDAwLAorICAgICAgICAubDJlY29tZW1fc2l6ZSA9IDB4MDAwMDA0MDAs
CisgICAgICAgIC50aHJlYWRfZW5hYmxlX21hc2sgPSAweDAwMDAwMDNmLAorICAgICAgICAuZWNj
cmVnX2Jhc2UgPSAweDAwMDBkODFmLAorICAgICAgICAubDJsaW5lX3NpemUgPSAweDAwMDAwMDgw
LAorICAgICAgICAudGlueV9jb3JlID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwyaXRjbV9zaXpl
ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwyaXRjbV9iYXNlID0gMHgwMDAwZDgyMCwKKyAgICAg
ICAgLnJlc2VydmVkMyA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5kdG1fcHJlc2VudCA9IDB4MDAw
MDAwMDAsCisgICAgICAgIC5kbWFfdmVyc2lvbiA9IDB4MDAwMDAwMDEsCisgICAgICAgIC5odnhf
dmVjX2xvZ19sZW5ndGggPSAweDAwMDAwMDA3LAorICAgICAgICAuY29yZV9pZCA9IDB4MDAwMDAw
MDAsCisgICAgICAgIC5jb3JlX2NvdW50ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmNvcHJvYzJf
cmVnMCA9IDB4MDAwMDAwNDAsCisgICAgICAgIC5jb3Byb2MyX3JlZzEgPSAweDAwMDAwMDIwLAor
ICAgICAgICAudjJ4X21vZGUgPSAweDFmMWYxZjFmLAorICAgICAgICAuY29wcm9jMl9yZWcyID0g
MHgxZjFmMWYxZiwKKyAgICAgICAgLmNvcHJvYzJfcmVnMyA9IDB4MWYxZjFmMWYsCisgICAgICAg
IC5jb3Byb2MyX3JlZzQgPSAweDFmMWYxZjFmLAorICAgICAgICAuY29wcm9jMl9yZWc1ID0gMHgx
ZjFmMWYxZiwKKyAgICAgICAgLmNvcHJvYzJfcmVnNiA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5j
b3Byb2MyX3JlZzcgPSAweDFmMWYxZjFmLAorICAgICAgICAuYWNkX3ByZXNldCA9IDB4MWYxZjFm
MWYsCisgICAgICAgIC5tbmRfcHJlc2V0ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmwxZF9zaXpl
X2tiID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmwxaV9zaXplX2tiID0gMHgxZjFmMWYxZiwKKyAg
ICAgICAgLmwxZF93cml0ZV9wb2xpY3kgPSAweDFmMWYxZjFmLAorICAgICAgICAudnRjbV9iYW5r
X3dpZHRoID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLnJlc2VydmVkNCA9IDB4MWYxZjFmMWYsCisg
ICAgICAgIC5yZXNlcnZlZDUgPSAweDFmMWYxZjFmLAorICAgICAgICAucmVzZXJ2ZWQ2ID0gMHgx
ZjFmMWYxZiwKKyAgICAgICAgLmNvcHJvYzJfY3Z0X21weV9zaXplID0gMHgxZjFmMWYxZiwKKyAg
ICAgICAgLmNvbnNpc3RlbmN5X2RvbWFpbiA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5jYXBhY2l0
eV9kb21haW4gPSAweDFmMWYxZjFmLAorICAgICAgICAuYXhpM19sb3dhZGRyID0gMHgxZjFmMWYx
ZiwKKyAgICB9LAorfTsKKwotLSAKMi4zNC4xCgo=

