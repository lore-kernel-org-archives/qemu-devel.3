Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB457C5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 01:34:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwVA8-0008Nh-9t; Tue, 18 Aug 2026 21:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwVA6-0008NT-I3
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:32:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwVA4-0008ES-PX
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:32:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INl2s31833054
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:32:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vL6EilpIGkizHWX++hIEuUs37YE9GHOFZfdQUQTTLwI=; b=PqY22DFMPCK3Vetj
 mzeaZhFjp+db8Ibx+U6dOjdEoHryTiux5/HwBMF5US3UZxbQOvZla98nCqK+pisV
 OZ9ptjdC2Yad2YvFjgsGlTSLQaGf5M/nAhl6HNml9oL+bPOkao7JoM/BrjgXIdgX
 7RcxwvMOwDONpK0JT54X4z0u40sBpYvl82zflSJ6L8JEE6mBHMpCEoEy2P4/+bD5
 XSFj53R8iAUsFZW8P+96+iD2d7NCqPqN3RSu6franjAiztu53rH38KIDcvaiSUQx
 FukQkpu0vG/BjCoIO8wbd9I8kmTcFqxGw8k1PCmqdtautpR7LDO/o6WOid9YbaTQ
 ko3SEQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm0q99-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:32:11 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3954def0191so899540a91.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 18:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787103130; x=1787707930; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vL6EilpIGkizHWX++hIEuUs37YE9GHOFZfdQUQTTLwI=;
 b=ilcrnVTU1A5+ZWKMEssWzOb4KG8E9ccQZRO2YexunHI0No4E11l85/CBlXB+hPp2il
 iP9fO7/1GQbcjEkm6tHFk0jm9fW3izcXtGXn22KsLh5zRrEB1AG48irc7wkEzU+Uj2Nt
 kaiujyaTyZ9vHcYQCH3Kvk4oQduOklB0VsqVXPR/G27O9N9oOK5SBWILAyRXMC+5yNDo
 7lWhl6crbpHeihNXsj0tpxEYn4Fwq02bAWy858sXYAFsQoNHShxeNqMMrMswrIZR4gpV
 bL6kY76HybA9KjpFO0RnFhHlSC5qwcKQnmGvQtHOtjGOGfv9LnPENDpBV/D+NmAjTXTR
 5GkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787103130; x=1787707930;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vL6EilpIGkizHWX++hIEuUs37YE9GHOFZfdQUQTTLwI=;
 b=fBIqax3QBuSUzebISCkykv+QiCjcw3YNaeGsaCHIJuX89/0mmu8Thx2O49Ijpg1eLk
 4GYGyqvaLd7B8oNqO5U/u3EwAyzojUex+pkwOvg1KEgGVjTk+hLDz3NLqYFm5633vwZb
 bIGBiQI0ywljs3vqOxsxZWAPp5Lz6mu+ZIyXJ7HvinWQFNy0FM+PLhfY4Iw1cstc5uM4
 N3glvYyHiXoMfLA+aDf7ILjr2lVzrHIhveBnrRoPs48TmDx6uHAeDb+ZFkDZrDzI3XRQ
 oV+keWRSZvTLYMvzBmkuE/2mQ0cWx6mItBj0gKp4OogZC1RGCNsNA4WioJxHeQNIzNrC
 PFnQ==
X-Gm-Message-State: AOJu0YwmDjtxzifYRuZsJ6Lv4L8lEeAJCjT7kHDgpOLfaGgy7JDbHHtr
 o+229cexmt9pZtDP0ohjDOFl2PyQL8kS6PkD8OXQAFIHpfwsUMAuKjX7olouxblU8PpoWd0gWre
 1sARN7xt4W+Wuef1kge263oP0Ft8837875VQ792g7I2QQ4+HOrrhYPDNVd8h783191g==
X-Gm-Gg: AR+sD118XEcKNBB3BSY9IhBC5z6Uks+xAntsle7gtzSe/xJQGhtcuUAeRjX4i7FasuH
 Wt9kL6UNwaDI+rVrWuXU2NCt2XxCp9S3HHmeQqjfJs4yApCQfGAj0whs3S7Gu5ryJ4Z7Wuh/yA3
 sHs/etV9UkO8OhR6SAzuyfiK3H8NPHKEaSfd46gM9cr9e+htXf9sIczUI9kV2urlYtHsQjUSXPA
 BcNS9o1LoOyZILD7rGg92XGabg6YLW1FlPHweqiDf3De755mo0DUWv/CdpscyhYKoWw13lecPVC
 6tQLpulwSCetSMeNi3wGR6fwpfkQN97kb4+7BYt5QEcu9pAY/5PrC7sniDs6NC1hxbqTiyY3uS4
 JEXtKOWWQxcXShr9W4jbYbqjIgR7qXMIVsAf7g1scoZeZZ4DS
X-Received: by 2002:a17:90b:4ac9:b0:37f:ed7e:7e42 with SMTP id
 98e67ed59e1d1-395810cad6amr1778267a91.14.1787103130454; 
 Tue, 18 Aug 2026 18:32:10 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac9:b0:37f:ed7e:7e42 with SMTP id
 98e67ed59e1d1-395810cad6amr1778177a91.14.1787103130021; 
 Tue, 18 Aug 2026 18:32:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327befa4b94sm1157539eec.13.2026.08.18.18.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 18:32:08 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 11/11] tests/functional/hexagon: update to v0.2.12,
 +test_{interrupts, sys_regs}
Date: Tue, 18 Aug 2026 18:31:44 -0700
Message-Id: <20260819013144.3264096-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: UH-5KBW_75hemdukxL5DHXoEnJxnh2Hl
X-Authority-Analysis: v=2.4 cv=bth8wkai c=1 sm=1 tr=0 ts=6a85079b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=0juuJDdZq1bm1YNGZfAA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: UH-5KBW_75hemdukxL5DHXoEnJxnh2Hl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfX/8eu8yK36e1M
 ml1WpNwtx9F03ykJcK07mTrz14+1KXu2u49guqjbqCMkT6bTv/CeGRENiZhnAGw4xxsP7gOfixe
 eWs2VDIuMQ7J79LcabfPHRYGBxKA2G4tezY6LBSaIckaS3b6Rsfe1dl5PSVV1xo8uoe6JgVPRXh
 5XGdOcLtEPsVWg153jTFH0HxZMquq72sQMVZaiOl0Ds2teMwkPuS6GfJRoP27eBPHVJ0xFHLybh
 onCy/0biEH8km9W0Uz1hMn2Y5EME0p5Qge75XXAGvYcC0psAcujJfJmPBZM6lqvx/U3CCQhSLrv
 FwVz4ccPqC/7OwXkPMMzMRFj7fVpgXCBnRBOXRkavFgKP1ZOxWVTKzkyKN8S8cT2efobOaQXRxn
 ww7fmNqbJykXAvxSI2KyF+rHdOR0kIvp07xMrAp90G5fAKuusMJzr+TVbgqVTNXcosnOtZrLHkW
 2hvUOqnKK7lFrdix8jg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfX5uYyeAqfHaaD
 VIDzYALHcDZUmNu7vJcnffQ72D2i1ozP9ycChwfo8mPFTE8YBtaTya5K/OjIs3wjKuuTR9znE3c
 mV7/fte19daPBdbXuXVKWDYtVFJsUHI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190009
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

dGVzdF9pbnRlcnJ1cHRzIGFsc28gbm93IHBhc3NlcyBpbiBmdWxsIGZvbGxvd2luZyB0aGUgaWFz
c2lnbntyLHd9CmZpeCwgc28gZW5hYmxlIGl0IGFsb25nc2lkZSB0aGUgb3RoZXIgYXJjaCB0ZXN0
cy4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5IHwgMTIg
KysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rl
c3RzLnB5IGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weQppbmRl
eCAwODM0Mzk4YzNiMS4uOGU3MTM4NmMxODYgMTAwNzU1Ci0tLSBhL3Rlc3RzL2Z1bmN0aW9uYWwv
aGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkKKysrIGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29u
L3Rlc3RfYXJjaF90ZXN0cy5weQpAQCAtMjEsOCArMjEsOCBAQCBjbGFzcyBBcmNoVGVzdHNVYXJ0
KFFlbXVTeXN0ZW1UZXN0KToKIAogICAgIEFTU0VUX1RBUkJBTEwgPSBBc3NldCgKICAgICAgICAg
Imh0dHBzOi8vZ2l0aHViLmNvbS9xdWFsY29tbS9xZW11LWhleGFnb24tdGVzdGluZy9yZWxlYXNl
cy8iCi0gICAgICAgICJkb3dubG9hZC92MC4yLjUvYXJjaF90ZXN0c191YXJ0LnRhci5neiIsCi0g
ICAgICAgICJlZGI0ZjM3Yjg3N2EzYTcyYTBlMTA5MjA0Nzc0NThhNDNiNDAwNDVkMzQzOThmZWU4
Y2I3NjNmZWZkMzQyZjRmIiwKKyAgICAgICAgImRvd25sb2FkL3YwLjIuMTIvYXJjaF90ZXN0c191
YXJ0LnRhci5neiIsCisgICAgICAgICI4NzFhMzM5YmY3OGNhYzBlYmFmMWIyNTA5YmZjZDViMjQ5
YWQ4MTkwYmUzM2UwY2Y4NDgyODNiMmY2OTE1MzIzIiwKICAgICApCiAKICAgICBkZWYgcnVuX3Vh
cnRfdGVzdChzZWxmLCB0ZXN0X25hbWU6IHN0ciwKQEAgLTU4LDYgKzU4LDEwIEBAIGRlZiB0ZXN0
X2ludF9zdGVlcmluZyhzZWxmKSAtPiBOb25lOgogICAgICAgICAiIiIKICAgICAgICAgc2VsZi5y
dW5fdWFydF90ZXN0KCJ0ZXN0X2ludF9zdGVlcmluZyIpCiAKKyAgICBkZWYgdGVzdF9pbnRlcnJ1
cHRzKHNlbGYpIC0+IE5vbmU6CisgICAgICAgICIiIlRlc3RzIGludGVycnVwdCBkZWxpdmVyeS4i
IiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X2ludGVycnVwdHMiKQorCiAgICAg
ZGVmIHRlc3RfY2FjaGUoc2VsZikgLT4gTm9uZToKICAgICAgICAgIiIiVGVzdHMgY2FjaGUgb3Bl
cmF0aW9uczogZGNraWxsL2lja2lsbCwgbDJraWxsLCBkY3plcm9hLAogICAgICAgICBkY2NsZWFu
aW52YSwgY2FjaGUgZGlzYWJsZS9lbmFibGUsIGJhcnJpZXJzLCBhbmQgZGNpbnZhL2RjY2xlYW5h
LgpAQCAtNzAsNiArNzQsMTAgQEAgZGVmIHRlc3RfbDJ2aWMoc2VsZikgLT4gTm9uZToKICAgICAg
ICAgIiIiCiAgICAgICAgIHNlbGYucnVuX3VhcnRfdGVzdCgidGVzdF9sMnZpYyIpCiAKKyAgICBk
ZWYgdGVzdF9zeXNfcmVncyhzZWxmKSAtPiBOb25lOgorICAgICAgICAiIiJUZXN0cyBzeXN0ZW0g
cmVnaXN0ZXJzLiIiIgorICAgICAgICBzZWxmLnJ1bl91YXJ0X3Rlc3QoInRlc3Rfc3lzX3JlZ3Mi
KQorCiAgICAgZGVmIHRlc3RfdGhyZWFkcyhzZWxmKSAtPiBOb25lOgogICAgICAgICAiIiJUZXN0
cyBoYXJkd2FyZSB0aHJlYWQgbWFuYWdlbWVudDogc3RhcnQvc3RvcCwgTU9ERUNUTCBzdGF0ZSwK
ICAgICAgICAgcGVyLXRocmVhZCBIVElELCBzaGFyZWQgbWVtb3J5LCB3YWl0L3Jlc3VtZSwgU1RJ
RCBwcmlvcml0eSwgYW5kCi0tIAoyLjM0LjEKCg==

