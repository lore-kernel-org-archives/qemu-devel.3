Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE2010F6FBF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xad-0004eP-Rb; Wed, 01 Apr 2026 11:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xZx-00044i-OK
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:34:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xZr-00011J-FX
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:33:56 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631DPeve1893840
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jvNSC8poP+qwYtz1xZbovXiJMkmoZCU6yMIg796FAUw=; b=F6NmjzE9WfWJzYGT
 mBxxvebo8ebT4lfSK8X9gNT7e1ZmOU/nMS65ELmtbVU+PyVRUy6mx4bHdcdb7y1P
 N0T0bpEmPGj0qWxeyCakDGqrovkcnCZJH//i5AtgxZ+zIApxtmv3lyLPcd0ItN3N
 L/afv8314is0HNC0m0tY/bPdiGuEVkUe6yiXWM0JCrcK/1bUSIHQRXOa1nBhsXdB
 vzw9lbu3YTXlnAJxTmdp58qCufsR3SqzZp5BTpKmA2BraHQRPZYFxcGFV+ZQje3n
 +gPj8MNaYua9pvFja0d3kzDz7LsRssDaD+8EgiDukqKpsHohwVEko1lseLW217+C
 +i6Dvg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9483rmp8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:33:53 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b4076dc16so103362071cf.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057633; x=1775662433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jvNSC8poP+qwYtz1xZbovXiJMkmoZCU6yMIg796FAUw=;
 b=GrSOlNEA1EM0LlSAncpVmdvf1pePNIN6PkAb1rt+Rm6Vp0TazIEda95hS6qazxFZxG
 e8ouOq5bGxuaNeCksm3pvcaD4GA0ziZhdB3DaAUIfK6/X/IALmpjC3HXago7UBwONQ6q
 xrbSpc5SdhtRJ6Zd6VtW3ODmXJW53ARqSyEd0K83zUVj4/lMsoDZ700SsE/ELVbpgIRU
 1tQjTEiPXtc1GMzICoKEaRekRUrf3iWaB8lCgqyMMDodd/4REyh+Gg1wigCOqmlcvw4Y
 ABYlHWzwj97TmM3oLVicCfT/DXBfwZa/ZfAAJ+PN4DV+CnyruOBg9Kam9PmMpyFhSMwY
 Kjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057633; x=1775662433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jvNSC8poP+qwYtz1xZbovXiJMkmoZCU6yMIg796FAUw=;
 b=WdxZg4GC3GLlWa4OsA3lpOQ2srtnnh8Aero3t+Jb9o9zHoA7XH/QZafn35p0e2TDuU
 H02ChDnp9dESnW8eYlDIvfgZWLfS/Ue0X0GR+4OaQJAwMBnjGRLRvrb3PqWL/PbnWvQ4
 v1w1J/I2SC9UzClS3FhjRNr9dpWzgALMI/t/THAujSN+XwUmFBP8LWP8zYW1SqctRT2u
 zPxVoudksBmhvQrdsfFAS0Y9nf3Vv1Gn26JGiF6luiP9/I3EDls6rVX8/sTZi8NXq2bH
 gHODIFGhFSJgiSkVGeLpOCPQYHt1KU6uxrkUAhmO2La8bL0lvwuHvoRQdczDxrbNqjhA
 Eslg==
X-Gm-Message-State: AOJu0YzDV5LQVlqZVUmrWN5tzEvr9Xfy1jeLZUW4WaIJ0jEvOxIoGRnr
 AYuFAwvZEBFkZfiDLMbKmpg0NL9++YOS2zTZ78+dfyezxMJ4UssJqUzGp666f5ZDK9YNKHJAtT5
 k8aKg4SEkTTxiOJm6w0wvga4IwyzFURG17l3ygn7Eqsa1ciC0ucNM7iRjQIWtuqT7pg==
X-Gm-Gg: ATEYQzyrZCdWaZaXwjmVsLkY5QqscJRY8djt4VzXGMT6Cv2oGHpK4YlMFedHN4NLEz4
 QNZrjqXLhH+/8pa2HEx3lTWIy6qw+5R8xOgkL7RTRqSPsvJEuUsSiFzAljk98t+2y7rVzP2C5Gm
 DOsfJQDpSFbQw5aYkHjxHOcMBh3CQMl6Yuk7J9Wyx813OVEBmPXRAjf9n81T9kK+WFLgZhZWAck
 k66fyrW4k9QItU8AvRTAUtQT8dURsf9qloxnOOg/NqZJtQPwHpCVigUl9KRbLIhawFzQU77ojfp
 Xo+nMzkGcjzjgAXiGVJtuYNmDq5HYbTW5dB6evSTp5j/Dh5bI6xb6jgZ21QQKUFLEDD95APVlsb
 n7TPLF8So+ABXHoGfMdxJ+0VziMdl5WdXakS142OqRjOwElT+C2QKyvXGYYfaZnis4KxKAw==
X-Received: by 2002:a05:7301:7214:b0:2ba:8018:cc57 with SMTP id
 5a478bee46e88-2c93106db14mr1868996eec.11.1775057268110; 
 Wed, 01 Apr 2026 08:27:48 -0700 (PDT)
X-Received: by 2002:a05:7301:7214:b0:2ba:8018:cc57 with SMTP id
 5a478bee46e88-2c93106db14mr1868972eec.11.1775057267594; 
 Wed, 01 Apr 2026 08:27:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:27:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 02/37] docs/system: Add hexagon CPU emulation
Date: Wed,  1 Apr 2026 08:26:22 -0700
Message-Id: <20260401152657.314902-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RYydyltv c=1 sm=1 tr=0 ts=69cd3ae1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=2pVdXvZyqgCw3DkElpQA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NSBTYWx0ZWRfX7UjM5jXcOwvP
 ShsD12aX82J59atSA1YvuHiZBVWnc+OjGcz9I0OHg5TXrhOFyPwXirOqrAyFWrV/87fa/BNn8Zt
 IW+IFCCuCgW0lrqLc4vAa5sdFSXr3Edu8Dcs/BA4t6HFQAmxUKeSJAnIoDTOg608lXGsKr3mIto
 GHGq15TAYXAfa8Fejuj0zWx4+cBNLm3Gj6e8DlsfEB8jAW82n4KL4agmIj9PkPaLHOzlzOzkwlJ
 Tunjs4jPd3OFa9rPtfMYRnQk+GmStAT7i8y/AquTFqFZBPQhhbgUPunnGxydXBmjvVNWZdOA7jI
 aVR+Yrt1tnf9vZLfv3S0oTfH2rnFd5ejWSqLKWMUohyR88xUBAqaJ/2y+CW6RY5kIRE7YtxAxYp
 f8wd0OpAvlTi1laZhIMhKN0p62VciecMcjen7BJzpOnDBElwlisRtWsjfJvF9HHMFCXNTfjm2ej
 3rTxgYVzU7rU7QZ7EVQ==
X-Proofpoint-ORIG-GUID: hU_GCYVIhLX0a3XHt9xREoill-jbF5tW
X-Proofpoint-GUID: hU_GCYVIhLX0a3XHt9xREoill-jbF5tW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010145
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGRvY3Mvc3lzdGVtL2hleGFn
b24vZW11bGF0aW9uLnJzdCB8IDE1ICsrKysrKysrKysrKysrKwogZG9jcy9zeXN0ZW0vdGFyZ2V0
LWhleGFnb24ucnN0ICAgIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCsp
CiBjcmVhdGUgbW9kZSAxMDA2NDQgZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0Cgpk
aWZmIC0tZ2l0IGEvZG9jcy9zeXN0ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0IGIvZG9jcy9zeXN0
ZW0vaGV4YWdvbi9lbXVsYXRpb24ucnN0Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAw
MDAwMDAwLi4zNmY1NGYwNThhZgotLS0gL2Rldi9udWxsCisrKyBiL2RvY3Mvc3lzdGVtL2hleGFn
b24vZW11bGF0aW9uLnJzdApAQCAtMCwwICsxLDE1IEBACisuLiBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vci1sYXRlcgorCisuLiBfSGV4YWdvbiBFbXVsYXRpb246CisKK0hleGFn
b24gQ1BVIGFyY2hpdGVjdHVyZSBzdXBwb3J0Cis9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQorCitRRU1VJ3MgVENHIGVtdWxhdGlvbiBpbmNsdWRlcyBzdXBwb3J0IGZvciB2NjUsIHY2
NiwgdjY3LCB2NjgsIHY2OSwgdjcxLCB2NzMuCitJdCBhbHNvIGhhcyBzdXBwb3J0IGZvciB0aGUg
Zm9sbG93aW5nIGFyY2hpdGVjdHVyZSBleHRlbnNpb25zOgorCistIEhWWCAoSGV4YWdvbiBWZWN0
b3IgZVh0ZW5zaW9ucykKKworRm9yIGluZm9ybWF0aW9uIG9uIHRoZSBzcGVjaWZpY3Mgb2YgdGhl
IEhWWCBleHRlbnNpb24sIHBsZWFzZSByZWZlcgordG8gdGhlIGBRdWFsY29tbSBIZXhhZ29uIFY3
MyBIVlggUHJvZ3JhbW1lcidzIFJlZmVyZW5jZSBNYW51YWwKKzxodHRwczovL2RvY3MucXVhbGNv
bW0uY29tL2J1bmRsZS9wdWJsaWNyZXNvdXJjZS84MC1OMjA0MC01My5wZGY+YF8uCmRpZmYgLS1n
aXQgYS9kb2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QgYi9kb2NzL3N5c3RlbS90YXJnZXQt
aGV4YWdvbi5yc3QKaW5kZXggNWY3MDg0YTZhMDguLjQxNmI4ZjdiZTc2IDEwMDY0NAotLS0gYS9k
b2NzL3N5c3RlbS90YXJnZXQtaGV4YWdvbi5yc3QKKysrIGIvZG9jcy9zeXN0ZW0vdGFyZ2V0LWhl
eGFnb24ucnN0CkBAIC05OCw1ICs5OCw2IEBAIGlzIG5vdCB5ZXQgaW1wbGVtZW50ZWQgaW4gUUVN
VSBoZXhhZ29uLgogSGV4YWdvbiBGZWF0dXJlcwogPT09PT09PT09PT09PT09PQogLi4gdG9jdHJl
ZTo6CisgICBoZXhhZ29uL2VtdWxhdGlvbgogICAgaGV4YWdvbi9jZHNwCiAKLS0gCjIuMzQuMQoK

