Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93490CD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 23:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKOth-0005mn-LV; Tue, 05 May 2026 19:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOtf-0005mA-97
 for qemu-devel@nongnu.org; Tue, 05 May 2026 19:09:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wKOtd-000493-ER
 for qemu-devel@nongnu.org; Tue, 05 May 2026 19:09:47 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645LXZ8X3501529
 for <qemu-devel@nongnu.org>; Tue, 5 May 2026 23:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=9q2AloOv4/RFJNVTw3ofqaACNk584FmBu9v
 gQxcl2y0=; b=ehQmV7teulpBQA/h9QiQNQxIR1i2o7N0ytxSlaraY+hw/3Yy0uh
 XqUW6htlV/gUgoEmw2bM566luq8ghUz+x91cFgt3CpG6FjdBVAG7nsgUWGAsvOJh
 CT2zfsau5wrNF3xEBtv2C9Ckz9fgJ64w2VIoS9cArY9/4+nGr1V987ps6+aIgH2x
 m6lcoG7eeu6pueJdcfhfntrREbcswr2rDLSeLljvxgwU4IJe4NqZgB+e4h9h+UGq
 guxHG5We4eb9rqmeXBNq5Vh2njhXxnnnLXwDWmv7I9e1LXB/S7rLUIcbBCtrmm8t
 Z8c90hrRb5/kqeRAj/RMb2T4WfMpra3E3KQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyhqfa4ff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 23:09:44 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c0f6593ef5so8250731eec.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 16:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778022583; x=1778627383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9q2AloOv4/RFJNVTw3ofqaACNk584FmBu9vgQxcl2y0=;
 b=QfXde7iy9TIzikdRebgjGVxpcrEw6c75UDIowzdNjjzwthx+sDSmHXxIrk+EP5Vb6w
 Mrq58jDd/FikjvkQvoh+1O3Ga+eXVQjyp4BPoQpIsU6831g58FOBePayN4Jmoi9beJZ9
 gHjv4ycLCJekmzazFXL5VU9yUsiVSDzZNHm+sOvJNS0/U0wC6RgX7juejtKxvO7Pzy/V
 +0wPuSXHM0Hi9FdcHWSw7n0m3Q7I1gW+VTwVwzxnXA9BpLzOfkmch5lWtlwGxsSiygVd
 l7S4wi8FMUdh7Fb4yG3sbFRrwa3VUFYw275le6HKEt4YhpUKY0PT30gcLwhi61FkzIlJ
 zCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778022583; x=1778627383;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9q2AloOv4/RFJNVTw3ofqaACNk584FmBu9vgQxcl2y0=;
 b=Bt6rPduxP110PYIW/A1mrwh5ppgr+1RC2f4O7tuPgJ29kqgwW8Prrw/4U5QBmSEIGo
 vYH5rLB6jVcmUczN7F6PepocSC230XXGF8SGkLAkaBWgmHggfaSBH0Md7RDNAj8PXRuM
 J9cmI2kBs1+HCqy9E9wl+QZaWYhsFlSRDiq1nMqxirN2ANql9FHX7GMQWUHkm0HVcqVX
 qgpYVjjinh5L7Wu1Gq9E5qRoxhOPcMEahbzW+srOSm6d4kl9hFJJeicqzp141faDkTLj
 +fQXo9mr/5bG3hSx55cgCmc0gWbP0EURehpgJPmJwgHkxREPzQyUC/W46XkSx2Nv0KfO
 x6Qg==
X-Gm-Message-State: AOJu0YzoLZGONpmvTLXvgN5Chd2R3XLYuW8gVvW3lHAwdu63oUPPMTGS
 QuPXwGsNHVKcngNBKnxWn8mlA/YZ5+kFeYAkXuPBe/3EWV0E4XQTnGkTIyjTbPIq5VOYU73Re4W
 85t97AkhrveevZ7aO7cbXbzb3obOpa1vbMdj5DIW0gRl7zSsG+zklOjladW4XAJLSCGi6
X-Gm-Gg: AeBDieuJk7YAVB2kG656Or1VrFyaflxML+ZvWTSvwMRvn3Pvag+uxt2+h521ki0o7Md
 EPGaqkzlDycN7mxH4Z3ekoEzdzHNP/7Dy7mnbV04FcA5gFiDCcYhfXHsqx76xHmr0B2NzDW4q+o
 nu+b0sG1/wyXnDRRpurFy9ByHEJw6dRY5c2E6wAn+DcNAwCHFAR8XcJBE9tf71wW5mQikCTtn8D
 IpP1MzfXKSs5MdrwNOIrdB0VXs4Dozev/qEAo8LQXqJf7VGX+n7OFNVCCuE1rtq4gpxGGKKcSNd
 pLdwO5yz/1iqwg1W2j8RuG0jhz5IcKi49VHTZ+qkSoEvIdpIX0G12Pa0mxWej5UdmDcsa1SWXtJ
 Wg3+I6+8MrFuuGgqNcg7CWzxjz1zyPhfp8xfXkgQ4D+sy1hKXMFtq5oGuIXNy7C/tMKiVis+Xe3
 7Kyg/Bm//krBFlbn2b
X-Received: by 2002:a05:693c:2b0b:b0:2f1:496c:94d4 with SMTP id
 5a478bee46e88-2f548895060mr575640eec.4.1778022582832; 
 Tue, 05 May 2026 16:09:42 -0700 (PDT)
X-Received: by 2002:a05:693c:2b0b:b0:2f1:496c:94d4 with SMTP id
 5a478bee46e88-2f548895060mr575635eec.4.1778022582355; 
 Tue, 05 May 2026 16:09:42 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f56f891a56sm991137eec.14.2026.05.05.16.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 16:09:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 0/1] Docs: add link to rev.ng video series
Date: Tue,  5 May 2026 16:09:32 -0700
Message-ID: <20260505230933.2712543-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDIyNSBTYWx0ZWRfXzyUxSqY3OA/n
 FFO+oVc2B+SOw3KmzhcEaCdzX5c76DkDjUhr1Xd4TygKDJlnfL9nohs4pV/y02dt5Apm02dVcDJ
 +UJmiKmdi3Jj2WfTWOlHmqmlgFIZUxLQX6XfSFMa0D5k4rvy2MV7qUmXUBIrI6G2bsVo/IKN+l/
 wKWF/eiTG0gYikI3D2tpAixxKzFv2RTj6u15tCEWzv1Fvnkl61n9IC/DYJXVAfogCvUL8q8jIDQ
 k9FbwGlIDOTmWXF7sggzdRiDRsDG0Y16iyCvHyl3bI5/RJuChASUa/tjcsgrHR2vfKUOMvdT3Jf
 xgSjj8+QYKe6ClZmqMJ+a7pa0eMhNdYDiGyevZVHz37dhN8E4fjMypa7V9NhR9/3ogzNmrbQNG9
 3kXXh4qxq+K6gumQNSiROPGLIhRI5RkfGZGPXvTmIpyd7grFGQE9B10/i6PCgP4ZtFUfbaXzkOO
 qoeyD4Xqy05srPETwjw==
X-Proofpoint-ORIG-GUID: Q5RYr0y-Z-EM2iVoOrEA_zVv11a6ETNx
X-Proofpoint-GUID: Q5RYr0y-Z-EM2iVoOrEA_zVv11a6ETNx
X-Authority-Analysis: v=2.4 cv=NPvlPU6g c=1 sm=1 tr=0 ts=69fa78b8 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=-AnQz9JOAAAA:8
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=nX7T0N7HZCusAIkz11UA:9
 a=bBxd6f-gb0O0v-kibOvt:22 a=3bnadFWGKyIZm4bBUiDd:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050225
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

The following changes since commit a85c588d07f8d3345ccad38b22026569a04571d1:

  Merge tag 'pull-monitor-2026-05-05' of https://repo.or.cz/qemu/armbru into staging (2026-05-05 10:11:49 -0400)

are available in the Git repository at:

  https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/docs-20260505

for you to fetch changes up to b7f9c5e3169bea0001e7d5618cb3a412bf04dc38:

  docs/devel/codebase: add link to rev.ng video series (2026-05-05 16:08:21 -0700)

----------------------------------------------------------------
Changes:
- [PATCH] docs/devel/codebase: add link to rev.ng video series (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
  Link: https://lore.kernel.org/qemu-devel/20260423213557.780112-1-pierrick.bouvier@oss.qualcomm.com

----------------------------------------------------------------
Pierrick Bouvier (1):
      docs/devel/codebase: add link to rev.ng video series

 docs/devel/codebase.rst | 5 +++++
 1 file changed, 5 insertions(+)

