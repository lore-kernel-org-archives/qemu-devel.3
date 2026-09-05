Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DDDC79F8B
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 20:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2weS-0001Wv-IF; Sat, 05 Sep 2026 16:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2weO-0001W2-Ob
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:06:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2weM-00062i-GQ
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:06:07 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685Hbepk1775030
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 20:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JKBO0Qe+gwKw5RssYbEzgdP0sigroD2JsRTcrpbm1Bs=; b=ZOwY/fSYkNw4JNJ6
 DieX6bK+FfzaLaD52abcQYPpXcASvG97QKuHBjydVyAInkvUROEOiRhnoo0DIOa7
 L3Ex6k/fkCxme350MIFDS07YlB6UIZHH74l2C8JM4tHg7HJ2pCA8Opp+gfMSGdeU
 j9loWMqyD3egx1DR4+BZNfLiSL2wemVRhGjyGYIGHuqcsbtcf/j0l4NBgwKo0Yfx
 3o2DLJEucftMhiBrt/A0sWWBxIfFGhpFpSb4EC1HWIXyfxnV+rlh/iS4Tsh/GY5v
 +7lNWjk5jSB+epsrwR+rDQGVjErPG3B2CmLoc7f4C9DPHNrUq6j6YYIktj2/L47w
 Ywf3NA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggc8ja1aj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 20:06:05 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38f5ac7416eso2655212a91.3
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 13:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788638764; x=1789243564; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JKBO0Qe+gwKw5RssYbEzgdP0sigroD2JsRTcrpbm1Bs=;
 b=AHp3rhI1Mw0YOCdNIuXNryUjt371FO5JLgXyXiE4Kn7H8NX2tR580dTF02wMjpTB8R
 Vi2neA/mMMnchkkAk4l0ehp7kCcO3qcgIh4uPTwoSyFT57Y2OqxOw6t8x3VAAhFPyl7g
 YP5Y9aYlJ1lHtgU4+K9xp1IQLH8Eipay+yLQIF9j21CLTyBPeWO6alN72n9xdZ3Cg8rn
 DvJ9Pq4BkWITOXX6HZR5o2VAHdCjElBVgj2beP7NZHn4Jr4MZRR4EzPUrIaDx8NPsoeD
 pljehlNhnr4FHX7PqwvXAHkslKFkO5HEkuUrIpp8PLW594H4huaGzBF72PhVjZNu1aqm
 r68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788638764; x=1789243564;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JKBO0Qe+gwKw5RssYbEzgdP0sigroD2JsRTcrpbm1Bs=;
 b=EUGUiN3F26ZW2Mc99AhOIOuvf57hNF5+d6kQb/DhEjy44pwCnPkMBybdxlfmo73KkD
 JqvH+Gl8R2mLzAZhCGhbs8vp3UzESbWZVWiwiPjWteJetdPpExIBsP236BJxfcyg4Vsp
 F7VMgRsy7hPdZLRSnF47tkOpKDCEyrYpOM1pwXdtIkMTO2MSC5k+IYadBgrmPPjRY5V/
 FZU5TBAn3CREwVXm+K9Wbh+MdxpVqPVsRoWrP1QG7L5QldN/kKF3okZ2U2PcfrzYk3zw
 //6IOsF/ir2bLLaWqoousQowMYUxjxzvDPQfmS7ztAok+RuarSOjcjIAp9h2gDJCvmcx
 trgw==
X-Gm-Message-State: AFuF++mNdWKedvwq+LOzuutlxeg4DWU+NKjx0ecdC4Ut9qGG/lAoCaxS
 JlFhjOkJVwXvosOXhA0F6qaMjA/yKu/OzIofid36CCHz4Y8sfLud/kOSzHDdaCmUjpLeHxrFjPQ
 7rPMGRk36EMo+WxzfxyjcC409TeFKU+tORGciO2oE/+AkkJXUr5xHOne8X9LJHwOZ+w==
X-Gm-Gg: AYBFou3FssqkB1UnJId5aYwIRBmbB159hMOXKQpQVg4CJbB8gspZ/zbf5ptylJYS04c
 p2BKuLYfINDimGO6hQ2G/YiVWPMjLVRmZuSCW62PD9Pia880vsRV49RV1xc3QZaIPRYjr/ckVjO
 5xIYdbaeLC6zHy5wwjhOZgM9zLLBNJebAIY/lKzF5NC70Td+/qMTaUNB3CYVvAI8tjwCaVrUC3p
 htMNwGBzhjLnekXXQuNqkhoxNYDCT+O032u2aI605uVSr6eV4HoU4eWhDElChW5RJvU97UFN40K
 ZqVVA9HqnBU4HmNq7DQd+wGAp6aasPNERzWrrF8llyr4FTv6qjJ/PTvvF7E9v0AzHNEz/0HZL1E
 yonlNnpcx8HkazyP55xkHEcHSJwPS7HyO6mtfdGgn9OhhK1Gd
X-Received: by 2002:a17:90b:2ccf:b0:398:a2a3:b631 with SMTP id
 98e67ed59e1d1-39b262aaf3dmr23075974a91.19.1788638764345; 
 Sat, 05 Sep 2026 13:06:04 -0700 (PDT)
X-Received: by 2002:a17:90b:2ccf:b0:398:a2a3:b631 with SMTP id
 98e67ed59e1d1-39b262aaf3dmr23075922a91.19.1788638763932; 
 Sat, 05 Sep 2026 13:06:03 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339bbebf2fsm17346075eec.25.2026.09.05.13.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 13:06:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 7/9] tests/functional/hexagon: add tests, update to v0.2.14
Date: Sat,  5 Sep 2026 13:05:48 -0700
Message-Id: <20260905200550.2009799-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
References: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: S1nCi7aBVxW93qyV0CkrPXPVpiPdwy6Y
X-Proofpoint-ORIG-GUID: S1nCi7aBVxW93qyV0CkrPXPVpiPdwy6Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIyMyBTYWx0ZWRfXw++7IUsYJUwq
 i6rGnsYlWAV9yM6s1X3YMtO4O5MDjye9Hlz++bcjwTGyiLOBLVNCMfktmlFB6PRSU2yNTUtaOGU
 dR3OOwRp1ZeGsYFdwaHhlErWoTHaxoJVtq41EbxqrZ60a4CUv8M7EV6+O8O+mbndWyf/ocbui5M
 NNpU7VQptXFu7ScNubitoIqpOH1+AI3vl0E2LGuPILvE+++Yr7TclB3akWzELc6m8WdnsBx2A3z
 HFecbOckKafyThYggebiTG6HJiSVY/SdCPMXqobAtFKU/AD3+W5TdsH+aL/i6nDY+xWsveqxDg8
 pAUTBcn19bN0JNTgimeXlJXRHy3TMDPbmf7qXyUWryo2WW3DTZ5TssuiAsaBE+q28W31m8XNI/N
 yFBJZmDb75TpKVWbC+I6LlAnygsQFJa0kAqMPWhiXsJPQg7pwqtAnnkM9NfL7eW01/La+pFElOK
 UwRZ3qMqx89wzcgVetg==
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a9c762d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=Hk3-jCc9Ay6NLlPe0nAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIyMyBTYWx0ZWRfX0b7XAFIUydg4
 +Qu9BkUnx12B7/hCOEfdHV9ga6dFC4xyxVlp1KhLXqPP3qiuUzXZmYOGUVgRMG/gQRtuP9ElNRD
 7R47tg9PEaCP7Nh3HAjb3nD+bAT7VCc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050223
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

QWRkIHRlc3RzIGZvciBkaXJlY3QtdG8tZ3Vlc3QgaW50ZXJydXB0cywgbXVsdGktVExCIG1hdGNo
IGNhc2UsIHt1LH10aW1lcgpyZWdpc3RlcnMuCgpVcGRhdGUgdG8gdGhlIHYwLjIuMTQgdGVzdHMg
YW5kIHN3aXRjaCB0byB0aGUgbmV3ICdzaW0nIG1hY2hpbmUgbmFtZS4KClJldmlld2VkLWJ5OiBQ
aWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSB8IDE3ICsrKysrKysrKysr
KystLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSBi
L3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5CmluZGV4IGYzNmUwMTVm
NTAyLi45ODNlZTE2NzJjZSAxMDA3NTUKLS0tIGEvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rl
c3Rfc3lzdGVzdHMucHkKKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3Rfc3lzdGVz
dHMucHkKQEAgLTIxLDggKzIxLDggQEAgY2xhc3MgU3lzVGVzdHNTdGFuZGFsb25lVGVzdHMoUWVt
dVN5c3RlbVRlc3QpOgogICAgIFNZU1RFU1RfVElNRU9VVF9TRUMgPSAzMAogCiAgICAgQVNTRVRf
VEFSQkFMTCA9IEFzc2V0KAotICAgICAgICAiaHR0cHM6Ly9naXRodWIuY29tL3F1YWxjb21tL3Fl
bXUtaGV4YWdvbi10ZXN0aW5nL3JlbGVhc2VzL2Rvd25sb2FkL3YwLjIuMTEvc3lzdGVzdHNfc3Rh
bmRhbG9uZS50YXIuZ3oiLAotICAgICAgICAiYjU3NzdhYTY1MjQ1ZGU3NzEwYTdhMDhkNzE3OTUz
YzEzNjJiZTdjOGI2MGQ5MDE0YzlmZWU4YjE3NjEwYWQxYyIsCisgICAgICAgICJodHRwczovL2dp
dGh1Yi5jb20vcXVhbGNvbW0vcWVtdS1oZXhhZ29uLXRlc3RpbmcvcmVsZWFzZXMvZG93bmxvYWQv
djAuMi4xNC9zeXN0ZXN0c19zdGFuZGFsb25lLnRhci5neiIsCisgICAgICAgICJmMGM1MzVkNzQ2
Mzg0MTI2OTU0NzU3YjZjZTU0NDUyYzVmZTgyNjI0NjE4Yzc5ODYyNDk1ZWVjMjQ3MThhNmZmIiwK
ICAgICApCiAKICAgICBkZWYgc2V0VXAoc2VsZik6CkBAIC0zNCw3ICszNCw3IEBAIGRlZiBiaW5h
cnkoc2VsZiwgbmFtZSk6CiAgICAgICAgIHNlbGYuYXNzZXJ0VHJ1ZShvcy5wYXRoLmV4aXN0cyhw
YXRoKSkKICAgICAgICAgcmV0dXJuIHBhdGgKIAotICAgIGRlZiBydW5fZXhpdF96ZXJvKHNlbGYs
IGJpbmFyeV9uYW1lLCAqZXh0cmFfYXJncywgbWFjaGluZT0iVjY2R18xMDI0Iik6CisgICAgZGVm
IHJ1bl9leGl0X3plcm8oc2VsZiwgYmluYXJ5X25hbWUsICpleHRyYV9hcmdzLCBtYWNoaW5lPSJz
aW0iKToKICAgICAgICAgc2VsZi5zZXRfbWFjaGluZShtYWNoaW5lKQogICAgICAgICBzZWxmLnNl
dF92bV9hcmcoIi1kaXNwbGF5IiwgIm5vbmUiKQogICAgICAgICBzZWxmLnNldF92bV9hcmcoIi1r
ZXJuZWwiLCBzZWxmLmJpbmFyeShiaW5hcnlfbmFtZSkpCkBAIC00Nyw3ICs0Nyw3IEBAIGRlZiBy
dW5fZXhpdF96ZXJvKHNlbGYsIGJpbmFyeV9uYW1lLCAqZXh0cmFfYXJncywgbWFjaGluZT0iVjY2
R18xMDI0Iik6CiAgICAgICAgICAgICAgICAgICAgICAgICAgZiJjb2RlIHtzZWxmLnZtLmV4aXRj
b2RlKCl9LCBleHBlY3RlZCAwIikKIAogICAgIGRlZiBydW5fY29uc29sZV9wYXR0ZXJuKHNlbGYs
IGJpbmFyeV9uYW1lLCBwYXR0ZXJuLCAqZXh0cmFfYXJncywKLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBtYWNoaW5lPSJWNjZHXzEwMjQiKToKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBtYWNoaW5lPSJzaW0iKToKICAgICAgICAgc2VsZi5zZXRfbWFjaGluZShtYWNoaW5lKQogICAg
ICAgICBzZWxmLnNldF92bV9hcmcoIi1kaXNwbGF5IiwgIm5vbmUiKQogICAgICAgICBzZWxmLnNl
dF92bV9hcmcoIi1rZXJuZWwiLCBzZWxmLmJpbmFyeShiaW5hcnlfbmFtZSkpCkBAIC05MCw1ICs5
MCwxNCBAQCBkZWYgdGVzdF9hY2Nlc3Moc2VsZik6CiAgICAgZGVmIHRlc3Rfc2VtaWhvc3Qoc2Vs
Zik6CiAgICAgICAgIHNlbGYucnVuX2NvbnNvbGVfcGF0dGVybigic2VtaWhvc3QiLCAiUEFTUyIs
ICItYXBwZW5kIiwgImFyZzEiLCAiYXJnMiIpCiAKKyAgICBkZWYgdGVzdF9kdGdfaW50ZXJydXB0
KHNlbGYpOgorICAgICAgICBzZWxmLnJ1bl9leGl0X3plcm8oImR0Z19pbnRlcnJ1cHQiKQorCisg
ICAgZGVmIHRlc3RfbW11X211bHRpX3RsYihzZWxmKToKKyAgICAgICAgc2VsZi5ydW5fZXhpdF96
ZXJvKCJtbXVfbXVsdGlfdGxiIikKKworICAgIGRlZiB0ZXN0X3RpbWVyX3JlZyhzZWxmKToKKyAg
ICAgICAgc2VsZi5ydW5fZXhpdF96ZXJvKCJ0aW1lcl9yZWciKQorCiBpZiBfX25hbWVfXyA9PSAi
X19tYWluX18iOgogICAgIFFlbXVTeXN0ZW1UZXN0Lm1haW4oKQotLSAKMi4zNC4xCgo=

