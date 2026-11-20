Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2988260A2614
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aMzuOi1z;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=S2wgDLRx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSAk-0002yA-10; Fri, 20 Nov 2026 12:13:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSAT-0002vh-V0
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:12:58 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSAS-0003CQ-3J
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:12:57 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEffUo2946995
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H94EjNre9w4NR30/2zQfRAkYfSeNl9NtNJ0rW1z9QRw=; b=aMzuOi1zBbC9GTDF
 uGCWiw83hJUUPxVg19nkkVU6RKYEjgp94wwmhFjhfo27f1kGd0u6Ngaj5Wu1+a1n
 2fLZfrALxhDniHNfimvQYht9qF9rxZboydf5LsB5e+0jf4TJLe+4gUok7/KOvodO
 c1YVTqsJ8LcgikmpW1YyBRyONgGge59LMlLLARtHHLrZELDKAXN37giMyjmjUdIJ
 eyrqwHD2FmuBAQqwkoVAoQIH2HRgzMYR2m+yo9ojFcHE4rZDRlYgrSX/VwmT62++
 4YV2uxsztXaojR02cxrAfMks3aenVCxS4ETJUxnk9Hxn3vLqzbQwMl9+rsZ5+uve
 oa/jIg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjjaw5s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:12:54 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-94961ed97d6so197315485a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795194773; x=1795799573; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H94EjNre9w4NR30/2zQfRAkYfSeNl9NtNJ0rW1z9QRw=;
 b=S2wgDLRxYVPJw5tRZx6y3cxZsUdDLSvJFlD1V+TzKlHpWJfixVtdeoPeSu4YmCWxLy
 Bw8VFIoiEN2fTGB9BAXina7aelLguWzPeWkhBabRtgkeubgOdLLlmuWPXRP8RwvU6m3M
 Wm1GEOZNP0jncYDshpGkKobvAGR9u/cZXl56BGSOoKJmHWwTx+VsdOHDVJWUBT4bf4zO
 S4tmn9M4n+eumIbJQt9UmBJC34rxf02DALKkZxxsPZNPbpD4O4fad1VFDTFp1D056y8J
 ypfrLNcnlUMypA7knQykE+3cWOpdHlieyqoHFr2RsmRzGcfY7Ydmjb0SaZ3t1u4k5y/I
 PTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795194773; x=1795799573;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H94EjNre9w4NR30/2zQfRAkYfSeNl9NtNJ0rW1z9QRw=;
 b=B7v2Uoe/lKRfodMMlSetxxv8wvfPQhdkEWWUfkMAxMkb4FpUBnLequExrIS7AkWo/8
 mUQ+icbHQ/PsY0YINvAeTZD64lt0wmHqHkY1ZExlnNmHQWxn+IEWuTDOmTWD4DzUyNMQ
 CiJuQ2aoRjH4/AiAjcs99lS9i11K/BQElYM77wNUfVYdUjIAdzGbg1vOnrbZeh0N1EKO
 DNzLpnx6Xq5oaoBFr2/sUaCJ8j8gIPN7DJ75ywkFgNAbWwLXiXZJ+LVI8Ad0OcEHJFxk
 mELqwfk05AohKcZpE8li2YPUD1oqwG99RR3QZwMf55zeVotmmyRcAPxc4Na5eAurNoqe
 73gw==
X-Gm-Message-State: APuU4Z8xFK1ps3t7YnnP8oDuX1fLz0X2oMBPMkRYLpT8QryTu0HVkmeK
 EBqmdqwPj3WunrHijpYMZawjU8d5k9t+cOJEAZ3yFvWaJkXhewaQlMOqeepjuBUdoCO5kkYIW8I
 sGA3dKHEPyMhmjLorLQCdo5oa54UnMGYFady0gNWPtbzb7uehu5f+F8CfOcalBTt03A==
X-Gm-Gg: AYBFou1TsTgUM4DAt9jRnBcoCtDpUfHVbv1vO87ww9l4AmPBJBz/PiLJsewPITqoHQQ
 tvndCsjWQTbh5+8/Lk/CrbGzvj71tHKdMjZWza2/bdFam7wMW2BnisoA5s5/UFZo+U9PWrkmu1n
 X8g/gw4M6PXJn7rGRHc57XGwylo+XfvIT7mPqfEgundeqS0PDLCOoV3wROdmOfZLtJguNWGcoOV
 V66TvtH2Bb4OSYnuD8DAVmKkkKoEa9QdrSMG8gdADJrx3AlXFIhYyw4guMJoQ+ClellTi7ipn4b
 p8tE9qtJv2xOEtihrKyHKSrLV0e/4enezC0lh1bPmxpUJmyr3j9PUjRxn+JydUd6+JJwISLDt9R
 zh/x092WG1vVJmizE82niA9QXad7JCMEX/G2PpPLRh1et2bwMbzwxkIPhQLJ6j13PKGal0WSB/9
 lnSz4yfX8WuRKJRQ==
X-Received: by 2002:a05:620a:6401:b0:93f:2571:c317 with SMTP id
 af79cd13be357-949b36030b2mr796091685a.28.1795194772708; 
 Fri, 20 Nov 2026 09:12:52 -0800 (PST)
X-Received: by 2002:a05:620a:6401:b0:93f:2571:c317 with SMTP id
 af79cd13be357-949b36030b2mr796088085a.28.1795194772314; 
 Fri, 20 Nov 2026 09:12:52 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9067846esm474755e9.4.2026.11.20.09.12.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 09:12:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH-for-11.2 v4 02/14] hw/scsi/ncr53c710: Do not load SBCL
 from DBC after a SCRIPTS phase move
Date: Fri, 20 Nov 2026 18:12:22 +0100
Message-ID: <20261120171235.61325-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120171235.61325-1-philmd@oss.qualcomm.com>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FJaOVOos c=1 sm=1 tr=0 ts=6b007f96 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=sMRSD98Anrl0H7Wvm04A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfXygLa60pVpwcc
 HG3Z3aunlNraYah6kzLah+Zy5SttvYFImzyGda3Xhg1Pw3lqYG8wqermgXUz9/OJSA4GdpOqYNo
 AlVs4nqhscYvRJ9HZGxWc0Ws8xbL/X4=
X-Proofpoint-ORIG-GUID: BX3PSd2QpLC0pAJ-stzxr-Cq5HCplx0G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX8iw/iPGnYml7
 Jl6nVjR/gb8FxewSGHvH8nidsQo+vAmqvxehvI4j4vNtbZXhRkUYe82lPpeQVFmNZPzCdj9iIcJ
 hH7eCec/7lxt7e0IJ7lOAY2H1YjQwUf4WKw/U/EA9y6CgrZT6wt4lqCRDHBPk/6DzyUOTIC3yKc
 gDfA0PvJcRBXdwkRYudp1Qi+uAAWuih+kYX/nU2hG11ScQtjcEMaK7Wv6LBz6Q8CM0wCnBKp6gC
 QF+oGaPS6zo8XCHC1P4YTtul9OrcUCDzQHXbAKrZtB4X2qXSUyWiY5+hWq8jvGz77g/P8Xf21NF
 tvnZFySMKdv90JLuwcPDCmuF6X+WJvIihROGZr2Avs5r+xp6oeUz2MLMJVvcCuKUjfEEPMAPfoR
 Db/1GzvmhTFRKRH9f+NPfm/OXN5CknPe5BS42CA0v8NC3AT30/yxBTKyNZ8KnLjzsr2eHUc7YnD
 YaqP+/U34kw6axM82Nw==
X-Proofpoint-GUID: BX3PSd2QpLC0pAJ-stzxr-Cq5HCplx0G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200068
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

After a SCRIPTS Block Move, ncr710_execute_script() copies DBC, the
transfer byte count, into SBCL. SBCL (SCSI Bus Control Lines) mirrors
the state of the SCSI bus control signals, it is not a byte counter, so
this overwrites it with unrelated data. The preceding line already
updates CTEST5 from the DBC bits that the chip exposes there.

Remove the assignment. The effect on guests is inferred from the
register definition; it has not been reproduced with a failing guest.

AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/scsi/ncr53c710.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 10daa66e840d..9ea2c47744e7 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1400,7 +1400,6 @@ again:
             BADF("Unimplemented phase %d\n", s->sstat2 & PHASE_MASK);
         }
         s->ctest5 = (s->ctest5 & 0xfc) | ((s->dbc >> 8) & 3);
-        s->sbcl = s->dbc;
         break;
 
     case 1: /* IO or Read/Write instruction.  */
-- 
2.55.0


