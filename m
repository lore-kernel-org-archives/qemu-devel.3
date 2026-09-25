Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F3A0C98326
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9Y-00054U-Tw; Thu, 24 Sep 2026 21:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9Q-0004yo-7D
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9O-0005tV-CF
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:54:59 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1kVfj4051925
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JwcyVV0Im3vuhgFNU7i08puH9HDt/9zr+/Z/bFI5GJ0=; b=VW4UAV8yPGNy0jkb
 mzPFpfZF6GpcBPU/HUJKNdKi/sQqt4qis5qav6vfnyGSb+QrBrfoPeajzuq2443s
 KkUukWVLzxWYEGADfyjWA5KIS8Te2w/FK/gg/od4LfHb/zGZ+VMkdY+SchOgU7CF
 g/NSMUDGKa8G0AHjTizPuvHzM0fUuk7LBm27Ho3v+LKiVjCkBOZEI3MUwhHXcCR2
 I+rA3FiVlrHeF8BRpKlygJJOf21PYDb7VR61e6aK8ImfzAltf4uN6pGnQ4qsREw0
 xyHreP/7o5B4eRVy+FmGfjXX9zG/EEpboGiPfDUr9eNGsq0ALyAh3KAxISqERFGf
 DjbLMw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw898skg8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:54:57 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso574346eec.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301296; x=1790906096; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JwcyVV0Im3vuhgFNU7i08puH9HDt/9zr+/Z/bFI5GJ0=;
 b=LiRylqlAcNG8sGoZsmokTutLt4et+89aUvuUnGwWyaM7IrV9yXZkCccfySSKP57u31
 2UD+NjEHBiCeCRccxl88KVsKePPudYb1YMHyGYWZcjXjzHQyH5NfSds5p+YRyVyjpllX
 zm7B807HH5BPddoblrehAik5ZzsCRRvVt4cnMxa3j8ePWJCpstWrLiZNTrP2SKgruplU
 eKCMr5RTrOXShq1uDF+N+7VFv/Z3HKUqZP3KnnpD/J8ZIXv8uiVUwvql0q03QoEyOEXD
 FDbhV7sbt9hX7E1Mw41t6QR9hEQuXnQH8Jpu+fuPQC45jSz0i3G7UG01du21XbwAFxZb
 RSPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301296; x=1790906096;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JwcyVV0Im3vuhgFNU7i08puH9HDt/9zr+/Z/bFI5GJ0=;
 b=eXjj7pGCwZ6C8eA52WRCYCTfRQZtgtwhjg3J8S6LcxSL4S7G46akUbcK/rUrao4Tfm
 +DcCwRqku2Ly29buQJQ6L1PlqMItYurJuCChbT/IrAxGw/oMIY8HjY0beJACpcTEp2JG
 mntepB4cIXSUp8Y7HEzbdi/7FSuZxm9HsLotHjFl0YiPsackSbki9tzvaLdnl2rBSa65
 IuZEYwLzoCsYDXC6SwbwVs+MnLOewqJhJ17zLRrxziVlRboVVM5Q8Tz0YncVmnT3Nsmo
 y4xoxXz6HGgbCAbrPTGBDDELu/xF5Nwfd/ETbd2pZUrGwiKMTTATN2F35jp38jGs+dEE
 jtwg==
X-Gm-Message-State: AFuF++k9fpGstEWsMcVVaPtXQxxmF6FuPthFGNUe1RnTQ7nnVwc+IRJs
 XB4mREg2S1HpZ4G2yPmBnsLUWo0q/0322zyKS8m3S1i/bIVNR3ozHFOSqE8WwfzSANbS/N6bT4t
 gz8AVhQlBxl3Lcbj37Ni74lIOiVpDy6GcB4TwKEGjFA4SYrcsYNnL/Ce9L2ApLeepgg==
X-Gm-Gg: AYBFou3XLa7My/6OURPiUMCe/ZgXaJbdxOOJ9Jbk6z5eKHmlEMOwaFxsUsYUjfU5ei9
 To0DndbMwXdRZp8M+eRQOSMAp9HX6BS+HpnjMPOOBLT7cGJpZ0HmDuj7E4RiTpAP7v/wZKg4X2b
 Ux8aeys124S0bGqHdGa1Ch+NbRG7+qzfjorPcb/Lce7JR/23Q2KIbllZrphpqafxXU5ee3RB2df
 TooQnbs3Vi3PZqQmcQkcAHkqYzWFzfqh1jP3dlUmZyLovOtcgevHkISHvVl3mh9XAwuq4NBWrJ/
 1NkPpBw/wobe8zS0ZTaxTpIg31Qpb4+QxVVyDtLck54NYAJwr5wqqDFdet9gOXof3tHOuygYKo7
 Dsvg3OF5ve3tmsvMaa4lDfeiMGiK4i3CC66A+td6Jd77aaYY=
X-Received: by 2002:a05:7300:fd16:b0:340:ef5d:3517 with SMTP id
 5a478bee46e88-340ef5d3737mr2699473eec.15.1790301296258; 
 Thu, 24 Sep 2026 18:54:56 -0700 (PDT)
X-Received: by 2002:a05:7300:fd16:b0:340:ef5d:3517 with SMTP id
 5a478bee46e88-340ef5d3737mr2699447eec.15.1790301295745; 
 Thu, 24 Sep 2026 18:54:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:54:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Sid Manning <sid.manning@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 14/40] tests/tcg/hexagon: fix undefined integer overflow in
 v69_hvx.c
Date: Thu, 24 Sep 2026 18:54:03 -0700
Message-Id: <20260925015429.2579174-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfXz/+9as6igBnB
 qundBpkNiEjqcPWUX708VuO0OK79pVAX6qO4tN9euXysCnjohcctMEnZqJH31570MXR5UgFfRE7
 J9pnKnOxrrI0WWE470yuqqaNK9N7IcxQ1t1UDsGaie9hhRDBqsJdDVASc7IAbtObNnUCfGqLwUO
 U3laqJSp8rHKeFUxIoKlGyOcWu8C7u7P/LOKidYlFezB7oFTuVJpKRw7fIIsMqOXB2oiwNnBMgo
 iTBihYdzk0SNa81WKUaDFEAFpQXC4v49v62VjXhpV+Oxr7bFu4c1sygRzz2OWJgMayd69V1NTf9
 VLC9IWuVhFEQh/9Jb/7P4nStaok2QeKFQ3iW4l1kiZRnRddVYm416Rcl6YiPHl6HC42Y5JtEtI1
 Yc9FhtZ0tZIHWfp+KGoeRfu6MPlUzmjgMB7q73Wy2qh+iluYr5X3rBYaezpiEhP/gbZGqg3IkOR
 Nfc+r2Ydp2MA5bho/Xg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX0qWv/Y7Bpi7E
 3QVCeCxbmvxjkp+vW6vlc0lHcdwaeSWykvEk49HXHNmv3Qu4bpsAvSlE8hrel6UDqixpvRKahp2
 D7drHcwUEfprdJgKcrTFDYCvpc7/GYc=
X-Proofpoint-GUID: 5AJ4Cp1V_WciEGJtXp3WRdlgz8BXLZtk
X-Proofpoint-ORIG-GUID: 5AJ4Cp1V_WciEGJtXp3WRdlgz8BXLZtk
X-Authority-Analysis: v=2.4 cv=EJWTQFZC c=1 sm=1 tr=0 ts=6ab5d471 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=hLQBpLl1in5vK7AdPdsA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250007
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

Q2FzdCB0byB1aW50MzJfdCBiZWZvcmUgbXVsdGlwbHlpbmcgdWludDE2X3QgdmFsdWVzIHRvIHBy
ZXZlbnQKc2lnbmVkIGludGVnZXIgb3ZlcmZsb3cuIFdpdGhvdXQgdGhlIGNhc3QsIHRoZSB1aW50
MTZfdCBvcGVyYW5kcwphcmUgcHJvbW90ZWQgdG8gaW50LCBhbmQgdGhlIHByb2R1Y3QgY2FuIG92
ZXJmbG93IHRoZSBpbnQgcmFuZ2UuCkZvdW5kIHdpdGggVUJTYW4uCgpSZXZpZXdlZC1ieTogU2lk
IE1hbm5pbmcgPHNpZC5tYW5uaW5nQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy90Y2cvaGV4
YWdvbi92NjlfaHZ4LmMgfCAzICsrLQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL3Y2OV9odnguYyBi
L3Rlc3RzL3RjZy9oZXhhZ29uL3Y2OV9odnguYwppbmRleCBhMGQ1NjdkMTQyZi4uZWZmOTM2MDY0
YTAgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29uL3Y2OV9odnguYworKysgYi90ZXN0cy90
Y2cvaGV4YWdvbi92NjlfaHZ4LmMKQEAgLTI5Miw3ICsyOTIsOCBAQCBzdGF0aWMgdm9pZCB0ZXN0
X3ZtcHl1aHZzKHZvaWQpCiAgICAgICAgIHBvdXQgKz0gc2l6ZW9mKE1NVmVjdG9yKTsKIAogICAg
ICAgICBmb3IgKGludCBqID0gMDsgaiA8IE1BWF9WRUNfU0laRV9CWVRFUyAvIDI7IGorKykgewot
ICAgICAgICAgICAgZXhwZWN0W2ldLnVoW2pdID0gKGJ1ZmZlcjBbaV0udWhbal0gKiBidWZmZXIx
W2ldLnVoW2pdKSA+PiAxNjsKKyAgICAgICAgICAgIGV4cGVjdFtpXS51aFtqXSA9CisgICAgICAg
ICAgICAgICAgKCh1aW50MzJfdClidWZmZXIwW2ldLnVoW2pdICogYnVmZmVyMVtpXS51aFtqXSkg
Pj4gMTY7CiAgICAgICAgIH0KICAgICB9CiAKLS0gCjIuMzQuMQoK

