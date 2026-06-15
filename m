Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA466CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZDkl-0005dN-Ma; Mon, 15 Jun 2026 16:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZDkW-0005bi-KB
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:17:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZDkU-0005Nl-1P
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:17:36 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIx6ZV881968
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:17:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Bg1IfQ+noC9UWvovh9NvDQ
 pPAfD9tkKIYAMSd1DlT6s=; b=djXajJtMiVM0L30T+Z0+rMXmPnxV+tUqT7AoM9
 8DP16FbeKj2vV8MhFljI1W2rEGZ4CCNgWcHvRwrmfD0kxgsDaO0GOh50MMDksjJN
 vnybHr4J4HLCMuUNTcDMgZ+1qaCKjf/eKuHXhZMl/sB6N4wyTBlWHWD3y9bm3dVD
 EG6LCcGXt53d9pWB/Xyh2NNnm3wCPPHVjcWVyIsLQFHBGxHUK8dfA8iaQKXIyENE
 SBq2Qw6ZXdNXNxtX7n/naAsnCnmDreO1QY3PoVxBOvveVntpRY/srQ0PP7lqP9CP
 7p9h6Wp3r8+yUKYIZyFf0chjgG3emmPMtDOaHUfWWZ6yAviw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etew0juab-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:17:31 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3080bb0267dso422103eec.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781554651; x=1782159451; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bg1IfQ+noC9UWvovh9NvDQpPAfD9tkKIYAMSd1DlT6s=;
 b=XPjVtWqrIPaeXWATvy4XepS2tmGhL75wMCwRc1icV/3ZyN63bd3eJjeyi9VrLvsuCR
 V/nx3fGcZMN41Bpc30752KEY4FPKnOelInl98owdFROOOWkistayf4mqWI4Lrsy/jDWu
 iDmdDmdhnhJpDMBIma5w649EaFtxSl3jg/ksRC32SAqoJ+QnUQW+5IV09olzpJF+m3xa
 ORnoKSRbVNkk1VfFjQ7AMC+9J2K++20N03TLPxfUfXSWDs8SSGd0wN72BTT4Q/cHAYp3
 /L+o4OUNNAuzyTotsmXEBNQG4BDEmJGNhEoYHef/gZaZGRd11Rtqqn8kU7TaufrPoP/1
 Y6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781554651; x=1782159451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bg1IfQ+noC9UWvovh9NvDQpPAfD9tkKIYAMSd1DlT6s=;
 b=juv6Uttlze0tfYTVdEl2RCig0X/ev3d8opDYUla9T7AXQzNUoYaFSW27FtFMFf3LI7
 yq3+KZdqLjwvdqiy8ByBnWTIgdUNgfI61VGHE481etx1R/AHcaJlNDfxh7hPMYk8+FL9
 NaHISHwnZ28OO0EqRL6k7KHWJMw9/4gmanYCo3kEvep6MW1KmAzIjNZvdCHZ9rdIqdzV
 t/dC55Y5yHwc+KE2opnYqIdOptLTUiFZjTMDmS32uss29gwyhlqeIAoOTH4YprY4HKHc
 Jk+2pIM1C8GlnAIR2vz+BgZER/OoS7QC4YziWTchvnj5uC86dgPVaAiaOv01Cx6y6gIx
 2b/Q==
X-Gm-Message-State: AOJu0Yz/q5V3k6lqfY5JVMEa5enjcGlf13rCuCCB7MLW2rEsU5C7MlLQ
 zU6ecX0soCIHBLz2Vyc7C/B8HHAFgpbaOolnlqdcahqOb2r2TfyIfxwBHBagAYnPIzZdC+ePbQK
 NHjA1fdRJARbvdi6vWKKr8YU47WOB/mlSKVpv5A85Dd5Tt6zjzQGzzqnFFTjyxG/Cj6fe
X-Gm-Gg: Acq92OHBXAqTJipev21A9aObhn+cXmSbn2anhhjtcLWJlWSfOSRK5I6trE8MGj/1kPR
 6Ofhyengr7yimhjPcDO2f1bSJIlfQc6liRLt+7LfkDj5uI7FAB8RvSXmjhnZox07NJgj/GfXJbB
 mBHVOuZcQ5U/1Wht4H5xoIDIoJlnClDSakzG2FGOkeqrDy1hkaYaJ5GeuwkvrMFndzuu7D+Ms1t
 AvgtObKMtiosAcKvSW1SKJYOUnzYJMyIjSitdpSsLHr+hnjRbJg4hd3HHRkNA8oiI1tz86e/N4v
 irioY+frXc9mY8bC9fHqMg30WNgRx4Di3wGRop+r0QbeJZZEkFARE5hu7I7JXfymWp+KyVDbl3/
 Mmhly/KjwymIa3Ijjtr970mVt76mYi9MTVA3N59tT6jh6nS5v0y14zEKI6qg4MYmGJalcZTV6sq
 6Fmp3Qrg==
X-Received: by 2002:a05:7300:724e:b0:304:9b48:53da with SMTP id
 5a478bee46e88-3093d25a08bmr6185204eec.26.1781554650751; 
 Mon, 15 Jun 2026 13:17:30 -0700 (PDT)
X-Received: by 2002:a05:7300:724e:b0:304:9b48:53da with SMTP id
 5a478bee46e88-3093d25a08bmr6185175eec.26.1781554650165; 
 Mon, 15 Jun 2026 13:17:30 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d810fsm16435237eec.12.2026.06.15.13.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 13:17:29 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 philmd@oss.qualcomm.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 0/2] MAINTAINERS: enforce file entries are consistent from
 meson
Date: Mon, 15 Jun 2026 13:17:21 -0700
Message-ID: <20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIxNCBTYWx0ZWRfX0N+QdJ8nArze
 fymzn2KhGrkrs8wdjoXChFJEBSgbtuuqk+x30e0FAnGhWVVOWLOKOWOk4TRPn4oKC7cL0qo4b8S
 a6M0v0Wz6g2SeEwoABPgFHYuCR/wQvc=
X-Authority-Analysis: v=2.4 cv=QLlYgALL c=1 sm=1 tr=0 ts=6a305ddb cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=Zlvt0_874LZou0AV2Y4A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIxNCBTYWx0ZWRfXyUetiB9Uj2lK
 yBAEVgwvLB/mio3RiLtgZKejewATakzUTLQhtzAUtR6dxBG4PRDxhejwK8BabSGq9v1Fmxd17Kl
 Ts4u33Y75Yk4MqbIOkKDeQKAw8M29ULXKf8hbR+vSsWloTxkn5EeIoxS6n3Fv5sHSABW/TA1xiG
 Iz6Qk/I/ksihjWhyVzhe4dzcYsFec6X1hO6azh+YrBD6bzgSusetdOzL9/Btu9lZ+MotDFjaLCu
 idxZiIv//L1JlYf0w7I+KgJ8uZ/cUnE436tS3Gb71mdGf+qko3T+opJ/16u9lFolwSSKzhvoz9P
 MkdxtvGrB4q3uxDYC+g7XcVfDWkMgMSstzL5YY6jMJ0TxnSXEH4FylPrWXXWYmVQvndtOFryWAC
 Vfq/sl83FITYTpHjBHqVGpkeRj0f4vLcCqLncOUuNjOiyru+rey5XhaprL/IsTp6Kmaw2ZrhmiM
 ZQ79C2AuyyRrXQnoasA==
X-Proofpoint-GUID: UYIFnwV4erUqGWgnRJaszPZ4V-1s3Ph9
X-Proofpoint-ORIG-GUID: UYIFnwV4erUqGWgnRJaszPZ4V-1s3Ph9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150214
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Recently, Markus and Philippe made a great effort [1] to cleanup file entries in
MAINTAINERS that do not match any real file.
Now it's clean, we can ensure it will stay consistent in the future, by checking
those entries are consistent, directly at start of meson.build.
Forcing this through the build system makes sure it can't be skipped, whether on
local machine, or in CI. And since anyone needs to trigger it to add tests, doc
or code, it will be detected as soon as possible.

[1] https://lore.kernel.org/qemu-devel/20260521080511.999266-1-armbru@redhat.com/

In terms of performance, it takes 0.26s on a slow machine, where full configure
takes 35s, thus a slow down < 1%: worth it for the consistency we get IMHO.

The first patch cleans up the latest inconsistent entry left, which we solve
pragmatically. Commit mentions another alternative suggested.

The second patch is the check in itself. There was a conversation about
comparing files vs list of files returned by git ls-files. I would prefer to
stick comparing files instead of playing with regex, but I'm open to implement
it another way if that's really important.

The usage is quite simple if you want to play with it manually:
./scripts/check-maintainers-file.py MAINTAINERS

Pierrick Bouvier (2):
  MAINTAINERS: fix entry for 'Python scripts'
  meson.build: check MAINTAINERS file is consistent with source tree

 MAINTAINERS                       |  4 ++-
 meson.build                       |  5 +++
 scripts/check-maintainers-file.py | 53 +++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 1 deletion(-)
 create mode 100755 scripts/check-maintainers-file.py

-- 
2.43.0


