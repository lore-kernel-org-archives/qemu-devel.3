Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7BB606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 23:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XjJZmtw6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L0dGXwr3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK1mq-00053l-2R; Thu, 22 Oct 2026 19:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK1mn-000538-KX
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:01:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xK1ml-00024J-GN
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 19:01:25 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MMF0MC393774
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xJoW5jHc+0suwOlKzY+Ots8Plvjs6H8MnOII1ZUOKso=; b=XjJZmtw6F2cEvWMW
 s1i+D8R35VmdmPG5OTORpVPpoQXrR6NXyVTukWfyM02CnWWk3tOhxDAOk1A0zzIl
 By+jVeIJcJao5FnjJnDmNqmy0wi6ZiSzLyZZQe5vobx8Lansu8ay6782jxEl+hlS
 fcJDWTvwmZrotafF4ngLRKt9Y4r9lJ5bk5kbqQz481YQrOLRE7EIU1uzdfUJ77vU
 HXllksVznpqpJa0lDwancmvBOEKICxb6yhSp+4i2HxF1cvTJvi7tKGI3UBs5amib
 udwFsl6WWPHgC2524so8GYYuax9cA0hUFBwf7i6/uAGynBSHS3jM8APNr9l6wkLO
 yVaVcQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtrw97-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 23:01:21 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-151dcfb1569so577179c88.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 16:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792710081; x=1793314881; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xJoW5jHc+0suwOlKzY+Ots8Plvjs6H8MnOII1ZUOKso=;
 b=L0dGXwr3cjBvC3iHRdC7QD6QZ7RycJXccoSpOqG/0h51kKvMozzitzP6JseCVHFlp0
 fM+xNMlnBWkUeP4qVt7i96Bg0FCcQdQTs25A/3X7h1xR4fzOk5QVM1TjXOWeNX5vzN87
 MKyNobzOpYft4NjowS7TYmhOEUbWxgtXdkepUp5ntUILbKFDg7ujhSh+NIV6ad963UKR
 Pd1ImO11XOw7k5XV7kw+APKBReB31dfw68+UQiCyjEVvEow/PZY+EwH7rXujJa8pxO+9
 TObir/QyU+tmSnhv4mZ6WIXoju1da7o5PXsI1gEt3eM0G1QWTZxPHqxAoTfp7Yc2HbPX
 JEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792710081; x=1793314881;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xJoW5jHc+0suwOlKzY+Ots8Plvjs6H8MnOII1ZUOKso=;
 b=wFpBepdlGarE0q7bUmVx+VW4gjYtxGBVQGVR6v7PDjz3abKNeaLR3MPcclMRbabjXd
 q53zZwQ/fkSywOkQpceX8ZHwIgCofnqcKd9PUKkSIP9uOWFA5Z5rrX6cUM+JzwKXbwv2
 woOhHDD3SJPrgOHb/tjolXTApCVh/reOV05LcGjKwZ3CBgGyY4/E/B2djwp2gxrkSmA5
 b30I4ftYXpfHorGI/MKtIuPD3txae9tmN1/aqZ8kAG8di5730uF59mB+0l9YEhEeVWtE
 8NEVVEzyufXhFPlK8oT5cPnOe0a2/sJL42JrK/PVCWkHCsplCBJ2rKTvs5otEqZYxyn9
 Py6w==
X-Gm-Message-State: AFq9FYLOTlNSuJk4pAC/Z740y+qmNtzbbBWc4Pv+JS/HF7W1GmUrxfJm
 lU9NbDKZApuSVGXpxnyZVSB9V+gvABxCDEm57otG1pgEarCjpaNK698XxEj/I0PTpDd8UkVcz2B
 J0mqkcaHq+ezYZQ/aU2tdDTv4vF4uQ99absrx7lqyZYFSQVYlAkXjOH4tf/FR9UhFFA==
X-Gm-Gg: AYBFou0/s6M+oNWdmCMyq5Cvnn5Wwce1DN1xfUgaMrfxnw3yUJzZBKEkiYK4vs12aV/
 jJzq4HjIlSYtgaS6QXVdllj73ndVYGbctngTrSsjaLS+1Ue3iKmI5noeCpiBQwwtyG1qr2IaFfw
 nc1L+IoLd6lfIlKUyQNDIpaofC1VsWRUYqwaWOkJI/Twtx5pWZBTTNfEGSLrsKJxzDpc7xRSaYi
 baH8zRifCThmw2g8+SIEb0S0JMn0WGgFF64TG2sjfxTTOtQIw5q5eZ5tYm2V0fpmJcN5JTXTUAy
 LjPVxtueSaPBchUrMuxbNzV9G3RTL1NOXqVU+unkAYcJCFght0aVVh+jD9nKmaKBRPaSyq6B5Q4
 7UfnARtmX33uJJBAmTtlisuDRXDRsKLg773fDazvVqTa93SD0
X-Received: by 2002:a05:7022:28e:10b0:143:3769:c680 with SMTP id
 a92af1059eb24-192f5c28964mr4602179c88.25.1792710081133; 
 Thu, 22 Oct 2026 16:01:21 -0700 (PDT)
X-Received: by 2002:a05:7022:28e:10b0:143:3769:c680 with SMTP id
 a92af1059eb24-192f5c28964mr4602125c88.25.1792710080290; 
 Thu, 22 Oct 2026 16:01:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9c0e60dsm1088138eec.2.2026.10.22.16.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 16:01:18 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Anton Johansson <anjo@rev.ng>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 12/16] hw/hexagon: add v79NA1 machine
Date: Thu, 22 Oct 2026 16:00:44 -0700
Message-Id: <20261022230048.2160400-13-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
References: <20261022230048.2160400-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6ada95c2 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=7BVmsqUksLU-FW-GvuIA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: qJtj06phemVBQY1jAY32Hl2jvfdBxwL-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfXwKskspEhzLIp
 hN5/0Gv9qLbqMfaTEjOCsvAQTgn40nm68sz8118/Zk9fwUm2J1A0/zATs/eIJiRiv+YyacXikF3
 IAfemRMcjYv5/FiAd32JbeyI6um0m8IRCkzNzBnhQbAhrxjI/9SKx+U/7Xe5c4wP/4ai2ZtuV2d
 /UKmgqzb76TWs/4AMkYhk+J9mDZxXgy9V2a/o1Inku0njbzwnr+WwFl8R/DfVSkKeY92EmrGpVZ
 bkA5yZQNBKvyUjYlhn4wM2oOUMx8RRJXSHB9aGgDEZMejMTQVd7C9YUOM6sNqDvIoyTxpGqklWw
 AxWIETOmS0kYR1PtbjQnbktvjDqD0GjrWtBIf/eR4YPp9ixiQfPsgfvy/D0glMSDQx27Igz8JXK
 8Xucs7u8cP9Of15ZqwePaTKt/6azxr3pn0H+32LM0l0FY2JSHSSja5fDhZp25wTpaefHcKisXdl
 fbuic2k1WErIgewrmVw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA5MSBTYWx0ZWRfX+1nbBraXsEHI
 7AhVJOyDjjjjtKPaMDDP1OtMz6RkYNjXBvxNDg54ijvLu6gbUbtR6y1OobwJUgVpyIcm3oKc4F1
 ddVFrvgQq8G3a+3upolxPlQVvHyJGIY=
X-Proofpoint-ORIG-GUID: qJtj06phemVBQY1jAY32Hl2jvfdBxwL-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220091
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

QWRkIHRoZSBIZXhhZ29uIFY3OU5BXzEgc2ltdWxhdG9yIG1hY2hpbmUsIHdpdGggdGhlIGNvbmZp
ZyB0YWJsZSBvZiB0aGUKdjc5IGNvcmUgYW5kIGVpZ2h0IENQVXMgYnkgZGVmYXVsdC4KClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBp
bmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oICAgICAgICAgfCAgMSArCiBody9oZXhhZ29uL21h
Y2hpbmVfY2ZnX3Y3OW5hXzEuaC5pbmMgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
CiBody9oZXhhZ29uL2hleGFnb25fZHNwLmMgICAgICAgICAgICAgfCAyMiArKysrKysrKysrKysr
KysrKysKIDMgZmlsZXMgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjc5bmFfMS5oLmluYwoKZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmggYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5o
CmluZGV4IDI2YjBhMWIzNzU3Li43ZDE1YTllMWViMCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9ody9o
ZXhhZ29uL2hleGFnb24uaAorKysgYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oCkBAIC0y
OCw2ICsyOCw3IEBAIHR5cGVkZWYgZW51bSB7CiAgICAgdjcxX3JldiA9IDB4OGM3MSwKICAgICB2
NzNfcmV2ID0gMHg4YzczLAogICAgIHY3M21fcmV2ID0gMHhjYzczLAorICAgIHY3OV9yZXYgPSAw
eDhjNzksCiAgICAgdjgxX3JldiA9IDB4ODc4MSwKICAgICB2ODFfc2M4NDgweHBfcmV2ID0gMHg4
MDgxLAogICAgIHY4MWRnYl8xX3JldiA9IDB4Y2M4MSwKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24v
bWFjaGluZV9jZmdfdjc5bmFfMS5oLmluYyBiL2h3L2hleGFnb24vbWFjaGluZV9jZmdfdjc5bmFf
MS5oLmluYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uNzBhN2FlNThi
YzUKLS0tIC9kZXYvbnVsbAorKysgYi9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y3OW5hXzEuaC5p
bmMKQEAgLTAsMCArMSwzNCBAQAorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b3ItbGF0ZXIgKi8KKworc3RhdGljIGNvbnN0IHN0cnVjdCBoZXhhZ29uX21hY2hpbmVfY29uZmln
IHY3OW5hXzEgPSB7CisgICAgLmNmZ2Jhc2UgPSAgICAgICAgICAgICAweGQ4MTgwMDAwLAorICAg
IC5sMnRjbV9zaXplID0gICAgICAgICAgMHgwMDAwMDAwMCwKKyAgICAubDJ2aWNfYmFzZSA9ICAg
ICAgICAgIDB4ZmM5MTAwMDAsCisgICAgLmwydmljX3NpemUgPSAgICAgICAgICAweDAwMDAxMDAw
LAorICAgIC5jc3JfYmFzZSA9ICAgICAgICAgICAgMHhmYzkwMDAwMCwKKyAgICAucXRtcl9yZWdp
b24gPSAgICAgICAgIDB4ZmM5MjEwMDAsCisgICAgLmNmZ3RhYmxlID0geworICAgICAgICAubDJ0
Y21fYmFzZSA9IDB4MDAwMGQ4MDAsIC5zdWJzeXN0ZW1fYmFzZSA9IDB4MDAwMDIwMDAsCisgICAg
ICAgIC5ldG1fYmFzZSA9IDB4MDAwMGQ4MTksIC5sMmNmZ19iYXNlID0gMHgwMDAwZDgxYSwKKyAg
ICAgICAgLmwxczBfYmFzZSA9IDB4MDAwMGQ5MDAsIC5heGkyX2xvd2FkZHIgPSAweDAwMDAzMDAw
LAorICAgICAgICAuZmFzdGwydmljX2Jhc2UgPSAweDAwMDBkODFlLCAuanRsYl9zaXplX2VudHJp
ZXMgPSAweDAwMDAwMDgwLAorICAgICAgICAuY29wcm9jX3ByZXNlbnQgPSAweDAwMDAwMDBkLCAu
ZXh0X2NvbnRleHRzID0gMHgwMDAwMDAwNiwKKyAgICAgICAgLnZ0Y21fYmFzZSA9IDB4MDAwMGQ5
MDAsIC52dGNtX3NpemVfa2IgPSAweDAwMDAyMDAwLAorICAgICAgICAubDJ0YWdfc2l6ZSA9IDB4
MDAwMDA0MDAsIC5sMmVjb21lbV9zaXplID0gMHgwMDAwMDQwMCwKKyAgICAgICAgLnRocmVhZF9l
bmFibGVfbWFzayA9IDB4MDAwMDAwZmYsIC5sMmxpbmVfc2l6ZSA9IDB4MDAwMDAwODAsCisgICAg
ICAgIC5sMml0Y21fYmFzZSA9IDB4MDAwMGQ4MDAsIC5kbWFfdmVyc2lvbiA9IDB4MDAwMDAwMDYs
CisgICAgICAgIC5odnhfdmVjX2xvZ19sZW5ndGggPSAweDAwMDAwMDA3LCAuY29wcm9jMl9yZWcw
ID0gMHgwMDAwMDA0MCwKKyAgICAgICAgLmNvcHJvYzJfcmVnMSA9IDB4MDAwMDAwMjAsIC52Mnhf
bW9kZSA9IDB4MDAwMDAwMDEsCisgICAgICAgIC5jb3Byb2MyX3JlZzIgPSAweDAwMDAwMDEwLCAu
Y29wcm9jMl9yZWczID0gMHgwMDAwMDAyMCwKKyAgICAgICAgLmNvcHJvYzJfcmVnNCA9IDB4MDAw
MDAwMjAsIC5jb3Byb2MyX3JlZzUgPSAweDAwMDAwMDA4LAorICAgICAgICAuY29wcm9jMl9yZWc2
ID0gMHgwMDAwMDAxNiwgLmNvcHJvYzJfcmVnNyA9IDB4MDAwMDAwMDgsCisgICAgICAgIC5hY2Rf
cHJlc2V0ID0gMHgwMDAwMDAwMSwgLm1uZF9wcmVzZXQgPSAweDAwMDAwMDAxLAorICAgICAgICAu
bDFkX3NpemVfa2IgPSAweDAwMDAwMDIwLCAubDFpX3NpemVfa2IgPSAweDAwMDAwMDIwLAorICAg
ICAgICAubDFkX3dyaXRlX3BvbGljeSA9IDB4MDAwMDAwMDIsIC52dGNtX2Jhbmtfd2lkdGggPSAw
eDAwMDAwMDgwLAorICAgICAgICAucmVzZXJ2ZWQ0ID0gMHgwMDAwMDAwMSwgLmNvcHJvYzJfY3Z0
X21weV9zaXplID0gMHgwMDAwMDAwYSwKKyAgICAgICAgLmNvbnNpc3RlbmN5X2RvbWFpbiA9IDB4
MDAwMDAwZTAsIC5jYXBhY2l0eV9kb21haW4gPSAweDAwMDAwMDgwLAorICAgICAgICAuYXhpM19s
b3dhZGRyID0gMHgwMDAwNDAwMCwgLmNvcHJvYzJfaW50OF9zdWJjb2x1bW5zID0gMHgwMDAwMDAw
MiwKKyAgICAgICAgLmNvcmVjZmdfcHJlc2VudCA9IDB4MDAwMDAwMGQsIC5jb3Byb2MyX2ZwMTZf
YWNjX2V4cCA9IDB4MDAwMDAwMDcsCisgICAgICAgIC5BWElNMl9zZWNvbmRhcnlfYmFzZSA9IDB4
MDAwMDQwMDAsIC5BWElNX2RhdGFfd2lkdGggPSAweDAwMDAwMTAwLAorICAgIH0sCit9OwpkaWZm
IC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2Rz
cC5jCmluZGV4IDg4MjRmZTEwYTU5Li45ZjZmMzRlZjliZSAxMDA2NDQKLS0tIGEvaHcvaGV4YWdv
bi9oZXhhZ29uX2RzcC5jCisrKyBiL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYwpAQCAtMzAsNiAr
MzAsNyBAQAogCiAjaW5jbHVkZSAibWFjaGluZV9jZmdfdjY2Z18xMDI0LmguaW5jIgogI2luY2x1
ZGUgIm1hY2hpbmVfY2ZnX3Y2OG5fMTAyNC5oLmluYyIKKyNpbmNsdWRlICJtYWNoaW5lX2NmZ192
NzluYV8xLmguaW5jIgogI2luY2x1ZGUgIm1hY2hpbmVfY2ZnX3Y4MWRnYl8xLmguaW5jIgogI2lu
Y2x1ZGUgIm1hY2hpbmVfY2ZnX3Y4MXFhXzEuaC5pbmMiCiAKQEAgLTIwNSw2ICsyMDYsMjIgQEAg
c3RhdGljIHZvaWQgdjgxZGdiXzFfY29uZmlnX2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lKQog
ICAgIGhleGFnb25fY29tbW9uX2luaXQobWFjaGluZSwgdjgxZGdiXzFfcmV2LCAmdjgxZGdiXzEp
OwogfQogCitzdGF0aWMgdm9pZCB2NzluYV8xX2NvbmZpZ19pbml0KE1hY2hpbmVTdGF0ZSAqbWFj
aGluZSkKK3sKKyAgICBoZXhhZ29uX2NvbW1vbl9pbml0KG1hY2hpbmUsIHY3OV9yZXYsICZ2Nzlu
YV8xKTsKK30KKworc3RhdGljIHZvaWQgdjc5bmFfMV9pbml0KE9iamVjdENsYXNzICpvYywgY29u
c3Qgdm9pZCAqZGF0YSkKK3sKKyAgICBNYWNoaW5lQ2xhc3MgKm1jID0gTUFDSElORV9DTEFTUyhv
Yyk7CisKKyAgICBtYy0+ZGVzYyA9ICJIZXhhZ29uIFY3OU5BXzEiOworICAgIG1jLT5pbml0ID0g
djc5bmFfMV9jb25maWdfaW5pdDsKKyAgICBpbml0X21jKG1jKTsKKyAgICBtYy0+ZGVmYXVsdF9j
cHVfdHlwZSA9IFRZUEVfSEVYQUdPTl9DUFVfVjc5OworICAgIG1jLT5kZWZhdWx0X2NwdXMgPSA4
OworfQorCiBzdGF0aWMgdm9pZCB2ODFkZ2JfMV9pbml0KE9iamVjdENsYXNzICpvYywgY29uc3Qg
dm9pZCAqZGF0YSkKIHsKICAgICBNYWNoaW5lQ2xhc3MgKm1jID0gTUFDSElORV9DTEFTUyhvYyk7
CkBAIC0yNTgsNiArMjc1LDExIEBAIHN0YXRpYyBjb25zdCBUeXBlSW5mbyBoZXhhZ29uX21hY2hp
bmVfdHlwZXNbXSA9IHsKICAgICAgICAgLnBhcmVudCA9IFRZUEVfSEVYQUdPTl9EU1BfTUFDSElO
RSwKICAgICAgICAgLmNsYXNzX2luaXQgPSB2NjhuXzEwMjRfaW5pdCwKICAgICB9LAorICAgIHsK
KyAgICAgICAgLm5hbWUgPSBNQUNISU5FX1RZUEVfTkFNRSgiVjc5TkFfMSIpLAorICAgICAgICAu
cGFyZW50ID0gVFlQRV9IRVhBR09OX0RTUF9NQUNISU5FLAorICAgICAgICAuY2xhc3NfaW5pdCA9
IHY3OW5hXzFfaW5pdCwKKyAgICB9LAogICAgIHsKICAgICAgICAgLm5hbWUgPSBNQUNISU5FX1RZ
UEVfTkFNRSgiVjgxREdCXzEiKSwKICAgICAgICAgLnBhcmVudCA9IFRZUEVfSEVYQUdPTl9EU1Bf
TUFDSElORSwKLS0gCjIuMzQuMQoK

