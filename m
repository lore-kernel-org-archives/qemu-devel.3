Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BA7CA6016
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 21:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEvNc-00052T-OZ; Thu, 08 Oct 2026 17:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEvNZ-00051v-C7
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:10:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEvNX-0001iD-M0
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 17:10:16 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L040B3648612
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 21:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RpkchvygE7d7fNxlQXaSJ4Iz5LFv9W8MgqA0CjyJn3k=; b=linMEnFWQffxylLz
 OsZkiAxsfZ2gaXf+o57ydwwqH+dgvarVeOpwOUgrCxwOBu50VsADGaSXyXj16HIS
 suIcmAIrUTRQr518mvc/b7XnHBCOJ1T+5f7Utm4g4fC4EQ02rRjc7sawqv34cMpg
 mfGc+Y3RgK5G2yHVSy6KZyH90qJARxGXN54lRKGJa/p0YHRU1Y7woAd/Bvyx1o64
 9SirW5UKafmNmSGbnHhJzJeveQU3hDgo23d8bJlf+VYglSCYgxwocZYZlNtsGxUA
 tabDd9uqqWWuoY3JDWZEPJ9FqdCLIzT5Db4Qgt8xfvd+nDmb7itIs35cPvFtP1iW
 NsV7tw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fmqrqre-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 21:10:14 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3515d2fc5ebso9132573eec.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 14:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791493813; x=1792098613; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RpkchvygE7d7fNxlQXaSJ4Iz5LFv9W8MgqA0CjyJn3k=;
 b=G5N17OxRoSeNSyjgLwuydtII9hrdc+mSDWfV2j26/FfuZW0tkBxIn0bL4wlrYuJMSD
 K1CTdZBdmppUVDjWHbr6dj+T3gvT5AfWz43vN4KCo50X77otyHNbJBBksj3tx0G1nUAU
 kNQYrukz1sMVNcwHyrLT8IQi70zo+ieDpcjzr1bDgGW3Qw25mo7S37IV7DbwR19cFhUh
 1S+1He0EL0I31oJaBrQD0PAT+mBap6uev6c6GqQ9nyBd4FCaLxqueU+cwBzKLAAQUPwl
 EY0AhDekKK964RD01jOlAELb48WGGSWh2NXqcQrpGFzTlXT8JtNNzCDMtlg+DG/qBycm
 cmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791493813; x=1792098613;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RpkchvygE7d7fNxlQXaSJ4Iz5LFv9W8MgqA0CjyJn3k=;
 b=dJyetiqry0e9qFAvNxDYQr+udqPy188AuNQyTRG3sHOuNGtuSx5qMuw/NVvl/Lk9aS
 UurpU/V1t6Xmty7ET1m7FP40jJiClU1lrUUJkN48U0lcZujLaRL65XS1dwR9SI3N6LBt
 EmTat4ktA2Mh45tOt5/35eD5ovkdIzAKkb3aP9ibR9OYt8lo/jgvnsZLhVNDkHUN+4H0
 XbFKLUKa1oRWdzD9XVezLrOA0P+Wk9fM0W+SKITuawMuZUW5bVwsSlxg1goVcpK+UJdH
 H/kPnWhz5g7ecZcRmJrKaDwkE1tX6Yp21Gz6cJP0aQQPWEFmGcglqMNcyvH1x8Ssxb60
 44FQ==
X-Gm-Message-State: AFuF++nfZyOGgcMkUPfxfISxlxjci15+I3e8Q5RO1lnk7d7iKQiFlAV/
 r2UMg4ICMBV6vzjtc6ErOCiE2rZWXeuJfvyqbAuioNQyBwQBGSVdQNC0DYWcZXwk/B8pYcgTA8S
 5X8jqKy6uIIOxoczQMgHVb/XbJByPdgmN7RPx40m6CDLpjxQpFauBP6V+tjKtoRZUWg==
X-Gm-Gg: AYBFou0Hkh6wI7Ek+b0wThrjnwgLW27dUfwo9K6gFPQTBa5vHU2ehBLEtIJeddzsxlR
 PYfjpvPMW9mlzAolLnGuK+IXnkdY7+jmOsVcGL2KIgkec2n53xlYwgHu0b1I3VynLfntarlccI5
 Pyh70L/nIpvk2H62g2g33+zetsZI52odhjAIO3JlgGuNJvKEp7MtuE1PULyJIVAvn99YUlVPMKz
 QzWiXuT907UPtpnrEVaRaix44XWGyeIjS1m3wTUasmAfsQvGFVLhUx9pxBZ+2wPbHjyrRWPy+rK
 JMUlVIODxysKN00jhXvdtu9L9XDn2HmG6RTZ+0MxDr5pdWfTUfv+OaoX+WwpNiTyrkHLhF2JELz
 EVLJdpmHWUqarY4HVZN7t5l+X5p/LP8Rj626EgevPXg91/QY=
X-Received: by 2002:a05:7022:e80b:b0:163:d97f:96f3 with SMTP id
 a92af1059eb24-16a0b84ee47mr103933c88.4.1791493813476; 
 Thu, 08 Oct 2026 14:10:13 -0700 (PDT)
X-Received: by 2002:a05:7022:e80b:b0:163:d97f:96f3 with SMTP id
 a92af1059eb24-16a0b84ee47mr103881c88.4.1791493812660; 
 Thu, 08 Oct 2026 14:10:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-169a31f6be0sm1628501c88.13.2026.10.08.14.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 14:10:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, ltaylorsimpson@gmail.com
Subject: [PATCH v2 4/4] tests/functional/hexagon: add bestwait systest
Date: Thu,  8 Oct 2026 14:10:05 -0700
Message-Id: <20261008211005.1853542-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008211005.1853542-1-brian.cain@oss.qualcomm.com>
References: <20261008211005.1853542-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX1zUd1bWrBB7N
 4eftd3oVUJjKhSpnTGWLnw1ZyPvo/Zrbk62jFA4/cTn9PEsrDzMHx13AlVGUQR/m8lUJ4mT6EEd
 Cfzpc33ydtXPqfm09aHQS1m705G1SEw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NCBTYWx0ZWRfX3IOsjIY8zo2d
 filnXvjCOfa6BZeIyiC7Z/IUsJvosBRXgiKyx/FdcYP1Nnbhi8MrKwCRwYzKJDU9s1wALXijZ/9
 VEjo7DDu2JgwtNDDA0vCtGuhXMQxrbPSPdsY40MdS22pY7Bhrxoori4Djwuzpea57MmEpFK1v3r
 rbXre1x11FolUEReu/QE8Da70+luj1vyNJaRnEDx9iIh62BX8UHcAo11LqXvcmXAA/Zz4xV5RUf
 mcqJFqpgJZyblqHcRsIzDU3YUvuV0QODRMWCWc+pFxofugMtt6cQ5Mq7Sr8NwG83jrYAuJXzCD5
 0ycBs0egW8bwU1BeOccyi+h5bSGOCwb8VKAl+5JJnr2nNb+5iFIg/zlbwbmkXh2/WJL525RnsRi
 o8aKsY3Yodc35twNpXnH5Dwz0kt/Fu7wxBJi9o334Gmv8w5Y5WOP7vi+lkrniMTF3Fn7dvrHngX
 hQe4KZz5tdrxwiHwEMA==
X-Proofpoint-GUID: kZ9CRhd6kSM_3VDIjx8SoXHg6Zhfo9HJ
X-Proofpoint-ORIG-GUID: kZ9CRhd6kSM_3VDIjx8SoXHg6Zhfo9HJ
X-Authority-Analysis: v=2.4 cv=IqCL47/g c=1 sm=1 tr=0 ts=6ac806b6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=L6WagNYi_-3FiElUOsoA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080084
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

QWNrZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9zeXN0ZXN0cy5weSB8IDMgKysrCiAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGVzdHMvZnVuY3Rpb25hbC9o
ZXhhZ29uL3Rlc3Rfc3lzdGVzdHMucHkgYi90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9z
eXN0ZXN0cy5weQppbmRleCBjODEzN2E3MTcxMy4uMjBjNThmODRmNjcgMTAwNzU1Ci0tLSBhL3Rl
c3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5CisrKyBiL3Rlc3RzL2Z1bmN0
aW9uYWwvaGV4YWdvbi90ZXN0X3N5c3Rlc3RzLnB5CkBAIC05Myw2ICs5Myw5IEBAIGRlZiB0ZXN0
X3NlbWlob3N0KHNlbGYpOgogICAgIGRlZiB0ZXN0X2R0Z19pbnRlcnJ1cHQoc2VsZik6CiAgICAg
ICAgIHNlbGYucnVuX2V4aXRfemVybygiZHRnX2ludGVycnVwdCIpCiAKKyAgICBkZWYgdGVzdF9i
ZXN0d2FpdChzZWxmKToKKyAgICAgICAgc2VsZi5ydW5fZXhpdF96ZXJvKCJiZXN0d2FpdCIpCisK
ICAgICBkZWYgdGVzdF9tbXVfbXVsdGlfdGxiKHNlbGYpOgogICAgICAgICBzZWxmLnJ1bl9leGl0
X3plcm8oIm1tdV9tdWx0aV90bGIiKQogCi0tIAoyLjM0LjEKCg==

