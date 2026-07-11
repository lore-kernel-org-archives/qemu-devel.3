Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB935C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 18:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wicqa-0000i7-FE; Sat, 11 Jul 2026 14:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wicqZ-0000hp-Dh
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 14:54:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wicqX-0000v9-H2
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 14:54:43 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66BHn9i0145453
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 18:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=3FOl29Z+ulFQZuW/IEzxJ4
 jxsVPwoAilL3Go2KG8BB0=; b=EspUlsFvBV1RDirxpdHK9HVGVwn5fwJkb67SUj
 0nfKlKcmOq6vYvISSmLIAYJhIf7hJ66vX4dZdXGhpSrc7UY6KyH6ypMOUFtsLrhg
 iPSjAdBsLEE5A3SpMII4Appnt4v17RsKxGInuFH3/htJdpZywBJHE8NfukEUBE4I
 bX+qnWliEeeyfLK28DAgSKBC7nBoPg36j2emhCoZQ+5mYIwvHk/T8ZzsnZSVSnhP
 H7QD+GK7DLRROMbGxh263mH1icGo3i47qVRRq9q7V1I6s9AR7V0GFUAHY9zQY0wM
 QUUKmV42yMvTRaRIHaRcoIaCIjy/IKVp2MbieCf7sYLMLV9g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbee9he22-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 18:54:36 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88aab7c1fcso4077580a12.3
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 11:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783796076; x=1784400876; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3FOl29Z+ulFQZuW/IEzxJ4jxsVPwoAilL3Go2KG8BB0=;
 b=J+UicAAyB15wDBITFgbrT/OUg33FJVFVWwb6WszKFd06OMfdsE+lzgaaeH1YA3EpcE
 rD/5okgliH5p29VeZHJKCmY5WosCN1FEiwigKKm/S84lO+sFqrePzt4jk8Zho57+8Gqe
 dyEUA9J8VJUn1Q6Fkgfq9lBQ3tK/d+iPmPked+wGSOJtZGp8ZCgYBZvsvCDEWketGUcB
 GI9nUzuqxfRL4h20h+QCO+VD6a7zeGpY32zYn9d5ZYQVAQCpZj+kE1TvvQfj8gIfcJSf
 icUFlTueyYLRPP+xl3E2rqhMtshQF5MMYpMTZbzXPvu7nburAJWZX9deJXdcOBxadbL5
 /xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783796076; x=1784400876;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3FOl29Z+ulFQZuW/IEzxJ4jxsVPwoAilL3Go2KG8BB0=;
 b=jI+TGTd2ES6gPz7T7UkaJX+1R8BhTxxW6Lyq7XmttkibChEChkIFvbimr+SORYFV4o
 Uxjye723LASA4wl2vb+lvAg9Nt3GnySHefN+F0KgtzU+eGpCRTeGmbmHoYEOzdGslNtP
 Vj/Xj0A7al0jh4DkEFaRKxGDtwZm9JHurMmkAsyOFQgoGh03DvSnYVEGDNexGF0mQC2p
 AW/4T2D9WsLhDU/6w2jKDRcHbxdO04o6LY+KgTpI/3UbhhSPpVNWLEs+xO0Lcc9PSskY
 HEwnKCZsPsJhIEUuL5nhb9ybzgfyQgXmwOSB9d2w5gkKIeJRL9xxQ+7MYH2EOeKDPGtd
 PrhQ==
X-Gm-Message-State: AOJu0YzBbNcIk0Cop8AkWqYi7cVCqltI4j1nDjwRj78nxQ9KKrYNoFxZ
 o/SljiRrbUBmAC74apozCwRDr/6/MuE9ozWZKm8b++PRR1F9GeB2yDBbjV27OtpWr4k1v5WAwag
 Ie94vehrWpYjAN/pd+2h+9AjzhVJ8cPfVKj4mb7GxEHLPC5obqbacj+wvv04TnFprkQ==
X-Gm-Gg: AfdE7ckOS4u1BYEZK0cbXwuDwN3rAuRR+9ZCT93Vw0mxhcvv7vM1pGgGQh/axjAEtKU
 Y94Kyf1JJ93u1u4hiW0xIoApS3fA5A40J+0HnrAVsfzwc1ERxx7SD7crhiSht8yVrb8GHDFNouy
 rg7AyoNHGfMBs2rIYi/MvB0XLUtmPWH13PGzpDig2aMJKO4Gpy2til00F3OVEp/DfUWwTzOG3Ul
 uQObOZO1QinHj4Y/+LH1mLOvx3qDPGiEfpZGvHZPdKvEvMLQkVap4kcR3N47tJB6lwlVj/Owwd6
 HmGNEPdXkjtEy2fdvDoW4mM77EDl939/GCQgiOaot1hf6QYlnZwQDdcuSgxml9+Q5FASUOtts78
 QFDDnhJWB0pZmkSw5o+R7fu9PZcLbz71Gg8DPhA1SsHp+IL9cANu2huoybsk=
X-Received: by 2002:a05:6a21:b8c:b0:3c0:b943:f984 with SMTP id
 adf61e73a8af0-3c1109e29e7mr3977412637.3.1783796075669; 
 Sat, 11 Jul 2026 11:54:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:b8c:b0:3c0:b943:f984 with SMTP id
 adf61e73a8af0-3c1109e29e7mr3977394637.3.1783796075218; 
 Sat, 11 Jul 2026 11:54:35 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm52953830c88.10.2026.07.11.11.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 11:54:34 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 matheus.bernardino@oss.qualcomm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v3 0/1] tests/docker: hexagon fix podman untar, 22.1.8
Date: Sat, 11 Jul 2026 11:54:32 -0700
Message-Id: <20260711185433.2021691-1-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDE5MSBTYWx0ZWRfX7VClwo4RyBge
 hH85a5TKnQEXoTKX2VdxJUZjOPv323FMytgXKLPG7BzLWrac79FmN3q5Lo1JvHwO+96YkJwD96O
 4jdizTaKxhbl2hPO43cB3vh7grvKifE=
X-Proofpoint-GUID: PPlzCql6Kg6tulXwjb5a_Sv8C8rWvmsr
X-Authority-Analysis: v=2.4 cv=a7UAM0SF c=1 sm=1 tr=0 ts=6a52916c cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-tt2qPmSz_yF4ARK8YEA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDE5MSBTYWx0ZWRfXyPeedeg9iIvL
 l9SJYchylWaxtOmltvtoQ9dbXKQr+l9WNRI3xtTbmWHEwhP/ANWPeTyWWL6fnPeTaEqPXUkDGqw
 7+kGqa5eRBd6h9fT2Z1v6TvII5VD3PUkmV8QQ/+h5yyvC7FZOCicTc0/YqctqekShmwhx1hyeU+
 nIndZLQ+B1qGuFLp7zBBhET+CGu1utXA1YtmMcrwuxeDWxz63p673C7Mzc1jGSorNUmCMXHFGvL
 pgChwCKNaS9ZsvphereHAXddvGlOm8uaO+AiysWU8Dy/fpP50fcw1kJVGHpWNS7SdB0AAohjI23
 CvJ5USz4k4xWZwxYp1bCIry+tnZ5F8sZGjEK3pL/3xPlJV17MXCkSYlnVcRQkiJlUWxdeaH1daX
 1qTen1FJimgx9EYO248qN3FP5neL/YyrYW7Ewulj2UqYgPfZ7RzNysYlc8YfjzSUlYjSLuDpzr0
 GJNsM0Mj1JNyIkY+L7Q==
X-Proofpoint-ORIG-GUID: PPlzCql6Kg6tulXwjb5a_Sv8C8rWvmsr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110191
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

VGhlIC0tbm8tc2FtZS1vd25lciBhbmQgLS1uby1zYW1lLXBlcm1pc3Npb25zIHRhciBmbGFncyBm
cm9tIHRoZSB2MgpwYXRjaCB3b3VsZCByZWR1Y2Ugc29tZSBvZiB0aGUgbm9pc2UgYnV0IG5vdCBh
ZGRyZXNzIHRoZSBsY2hvd24gaXNzdWUKdGhhdCB3YXMgdGhlIG1haW4gY2F1c2UuICBNYXNraW5n
IHRoZSBmYWlsdXJlIHdvdWxkIGhhdmUgYmVlbiBlZmZlY3RpdmUKYnV0IHdvdWxkJ3ZlIG1hc2tl
ZCBhbnkgb3RoZXIgbGVnaXRpbWF0ZSBmYWlsdXJlIG1vZGUgdG9vLgoKSW5zdGVhZCwgYSBuZXcg
YXBwcm9hY2g6IHVzZSB0aGUgLmRlYiBwYWNrYWdlcyBwcm92aWRlZCBhbmQgYXZvaWQKdGFyL3Bv
ZG1hbiBpbnRlcmFjdGlvbiBhbHRvZ2V0aGVyLgoKQWxzbyAtLSBzb21lIEhleGFnb24gY29tcGls
ZXIgYnVncyBmaXhlZCBieSAyMi4xLjg6CiogaHR0cHM6Ly9naXRodWIuY29tL2xsdm0vbGx2bS1w
cm9qZWN0L2lzc3Vlcy8xOTU0OTUKKiBodHRwczovL2dpdGh1Yi5jb20vbGx2bS9sbHZtLXByb2pl
Y3QvaXNzdWVzLzE4NDUzMQoKdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwv
MjAyNjA2MTkyMTExNDIuNDEyNjE5OS0xLWJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbS8KCkJy
aWFuIENhaW4gKDEpOgogIHRlc3RzL2RvY2tlcjogaGV4YWdvbiBmaXggcG9kbWFuIHVudGFyLCAy
Mi4xLjgKCiAuLi4vZG9ja2VyZmlsZXMvZGViaWFuLWhleGFnb24tY3Jvc3MuZG9ja2VyICAgfCAy
NyArKysrKysrKysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwg
MTAgZGVsZXRpb25zKC0pCgotLSAKMi4zNC4xCgo=

