Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572C660A260D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IxasUXWa;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aSFHeAZS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSBb-0003kP-Fv; Fri, 20 Nov 2026 12:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSBN-0003Qp-JF
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:13:56 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSBL-0003uu-VD
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:13:53 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKGFtQL3830233
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IUS94AHKdQNLJ61rfRyuLdV5pXwveMdl6S8QioZLG+8=; b=IxasUXWaBMBYTTUR
 WV5hdSysQZz945XnoVvPp8Iuov0wC2TxYZa8qi8AQs1fDXA0ap29ubzd7aeHz07J
 zBuGWuQxAa3V7m9y9snfkbnp3qDNQIs+zRXfPU4vSgqljxyW9zvllsd1W7FE5VZA
 fkS+9MF5QYnxnmvrmga/TeR4yYaPsMDi4HbH4n3UQ+cOsjv9MdBHrRNmhCXt3h7y
 SS/BwgQM7kn/KlKVXkSrUenJjGiP14QYhyLNWa4IBXvAsnL8QCmbVWLs7ccdh7zy
 HUoEibsiajBzwTe0a8FfkxKgeLDhrkLNdOpD8v93D4Mc3y1t/PIOwLcf20lez3qz
 Q//K2A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2sjwg7kg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:13:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94961511b61so203377985a.3
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795194830; x=1795799630; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IUS94AHKdQNLJ61rfRyuLdV5pXwveMdl6S8QioZLG+8=;
 b=aSFHeAZSltKH0rWyTrpJxbVxWlelhUbu6YPMUXNRuB1EF6u4TkioyvQF9dqeNnvKc+
 QUo6jocJ0vgyn195ThcolQBNTDx3EDndJZ9M0+rFkrJEsvVPlWa7tSfZM+H8tB0yaayn
 wv7HCmdxsLZL3KTX5HMcDNQClWcGu59J3VMsxnWvijzGLr6S4Fl+ny28MxgQ2h4TVb4Y
 zwlIFWy6KnY9odShGW9fMe3z43A285NyOv1ruWZZo69WAepE5HufypDTDesZC2dVSMSU
 fXxxlbtbNGVOCsi4i1qeMcQjk2mL1XZGeMcu0GY3MDLW1t8JXp0iuuQu4X15AD6hpQz8
 JxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795194830; x=1795799630;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IUS94AHKdQNLJ61rfRyuLdV5pXwveMdl6S8QioZLG+8=;
 b=kOti+yyMBzC95pBVfb5Fjtj/FWbbm6eCjdWBO27s+mHpIwmXszHnoPXa5cYoIoqwgs
 sI6ny3i2UGkllB6v9dbuuCTuWRsvWZuLIC05yteSUqK8K8sTOT+0BNk3N205ulQWceWE
 JF2P/BLt8hMP7lG2WSP0wgMwjH7I/Xcv7hwrnckgG5f5J2lnucdZ9XWLyvH1MdQYRukc
 gSEgCTezDChPELXxCfHOANKzZ92AGrQ8ECKDAnHuo3ZRRbS03WX/dn1T9toJMvhBGQW0
 ebR+0pWuooqUPWl4Dxpblt3fgdifQYqrdK2Fgz+c/oiXsfvjzXSHIbHSJKFYXtDh/xJ4
 w1kQ==
X-Gm-Message-State: APuU4Z9Jb2bmNBkF7xIs2hLZTFE3PfsnPiJqMsBerg87fVFrwzrmeLu+
 dwgT0PwlPKAGImoZ9I+sx/JF+BcnUk46TlfZzsITaWo0a0Pnp99+5CmJzJV3KKjLtos46UeY+sn
 glSZUMUHV1TolgtUlj9Ao7CnnwIxpNpvZqJwKzWQn2xGJ6HN7Pl2fQMVYo2lyRLK+pA==
X-Gm-Gg: AYBFou0nu64JLotmw9w8QMwqTSG+CeAMqMh4e7+XG1jDvSx4ADG1c3qSji4dzSp/Z+c
 c6hJu1EFlwX2QnOoHUftZTFg1yQMiLP+aVTMVvGnHUY0+N01FsadnNw2Wq6/TDDStDeHWhBmw0m
 Q+xeEFIp+CDBZBplFgv/SzXlErcZ3ViooCoMZ44e6+4NJryHMYFoE4XODLEcwF2tbxa53QNZnkp
 XMxIi8ZOjdBh/YLw+DygZQazudzlP+n2Ho7JVlNCwqF39hrURkRUtPWJ9DlsM8/TE1fg/J5R3uS
 T0w9cuZGeHGfD6GLKAnC2BaiUhUftccNs8IZZdgHBPn5jAVRAkeYqxm4hYMIFsaWzfDwEJRGaI4
 X4WRdlGkQF4CVZcjaWMfsmlxADhron99K2Dur+Gy1oEze9q4jXy3ZW3JLaxRiEliss2k41pBOg4
 qSJBuVU5SGNdl4RA==
X-Received: by 2002:a05:620a:6892:b0:947:7691:7316 with SMTP id
 af79cd13be357-949bab3d3bemr598921285a.81.1795194830158; 
 Fri, 20 Nov 2026 09:13:50 -0800 (PST)
X-Received: by 2002:a05:620a:6892:b0:947:7691:7316 with SMTP id
 af79cd13be357-949bab3d3bemr598916285a.81.1795194829688; 
 Fri, 20 Nov 2026 09:13:49 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb989e3sm7038401f8f.52.2026.11.20.09.13.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 09:13:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH-for-11.2? v4 10/14] hw/scsi/ncr53c710: Append SAVE DATA
 POINTERS after MESSAGE REJECT for HP-UX
Date: Fri, 20 Nov 2026 18:12:30 +0100
Message-ID: <20261120171235.61325-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120171235.61325-1-philmd@oss.qualcomm.com>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: P5g7PFB_kbHMeI9DmfFx_oaSrchYdi7m
X-Proofpoint-GUID: P5g7PFB_kbHMeI9DmfFx_oaSrchYdi7m
X-Authority-Analysis: v=2.4 cv=dZ4VTnXe c=1 sm=1 tr=0 ts=6b007fce cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=zCys0jnkAAAA:8 a=EUspDBNiAAAA:8 a=9Uk40hKUNlF1tgaBGToA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=AAPjE2N9MkmuCaafd2wf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfXxa6mWHTSPFaf
 GmdX5xvqC10bnb3brwcsHtN3TDE2jZ9DsPBS5CGWKTExab3iE5O4bK/XXlEoQfGSjVngcyBPVHZ
 mcrNYpN8cMri8EHcChapoO3bV3/0eNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfXwG6+DnUNbkJ3
 TwrEkFkPfL81CCMVr2SIJ1NeK+PjQs/jke2jifqA0nn9MlrPK8G8seosd9uZuvoNCOQ12Vm5L5C
 jdRYlmmVYoA5eqLnDa9hlo4/C6m/aXFOyoOp14DVTkLffmf1t0dDd3mF3usQVQdEuFJRB+wJXAY
 DabBsGgPfZEdP6OsKRPVMOsMs8JERVmL5TW/+VlvQVzUyk6aPU1oB6Z30Tz7a9Q3qUFjyO8H/+8
 siYi0U/VSk7X7aGLDFFWscg9XZuZuyZRudkh66cTc7MEpzG9euZsozfNy84jJsBq1irk5Z9j3tV
 wdTlJvfDu4J8B0FEs3WQ3iEq27xSMeO0bB5Yf2hpdz9gc5LOL6zQcnqU3L0lZZocv2Qwa9FPM1c
 UOd+v5nZ8n/TxJpl1JZ9JcW253CwlSg4gGmzeDJIYOdsoMSjL5dvS4r9DGB5hex/iegttABYSmZ
 uyTXLp2FQaXtxpiuRww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200068
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Keith Monahan <keith@techtravels.org>

The HP-UX 10.20 install kernel is nonconformant: its self modifying
SCRIPTS reads a second message byte after the MESSAGE REJECT that
declines SDTR/WDTR/PPR negotiation and hangs unless it is SAVE DATA
POINTERS, while NetBSD's osiop resets the bus if it sees that byte.
The two are told apart by ATN state as the reject is consumed (HP-UX
has deasserted ATN, a conformant initiator has not), so the extra byte
is appended only for HP-UX.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/scsi/ncr53c710.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 9ca025ff6334..dfed2f2f9fdd 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -699,6 +699,10 @@ static void lsi_do_msgin(NCR710State *s)
     if (!s->msg_len) {
         switch (s->msg_action) {
         case LSI_MSG_ACTION_COMMAND:
+            /* A MESSAGE REJECT declining negotiation was just consumed. */
+            if (s->sfbr == 7 && !(s->socl & LSI_SOCL_ATN)) {
+                lsi_add_msg_byte(s, 2);   /* SAVE DATA POINTERS (HP-UX) */
+            }
             /* Stay in MSG IN until the next block move requests COMMAND. */
             break;
         case LSI_MSG_ACTION_DISCONNECT:
@@ -794,7 +798,12 @@ static void lsi_do_msgout(NCR710State *s)
     }
     return;
 reject:
-    /* Decline SDTR/WDTR/PPR negotiation with a single MESSAGE REJECT. */
+    /*
+     * Decline SDTR/WDTR/PPR negotiation with a single MESSAGE REJECT.  HP-UX
+     * requires a trailing SAVE DATA POINTERS (0x02), which other initiators
+     * reject.  HP-UX reads the reject with ATN deasserted, so lsi_do_msgin
+     * appends the 0x02 only then.
+     */
     lsi_set_phase(s, PHASE_MI);
     lsi_add_msg_byte(s, 7);           /* MESSAGE REJECT */
     s->msg_action = LSI_MSG_ACTION_COMMAND;
-- 
2.55.0


